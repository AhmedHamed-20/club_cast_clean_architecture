import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/entities/auth_entitie.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/cache_access_token.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/forget_password.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/login.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/sign_up.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/constants.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.forgetPasswordUsecase, this.loginUsecase, this.signUpUsecase,
      this.accessTokenCacheUsecase)
      : super(const AuthState()) {
    on<LoginEvent>(_login);
    on<SignupEvent>(_signup);
    on<ForgetPasswordEvent>(_forgetPassword);
    on<AccessTokenCacheEvent>(_cacheAccessToken);
  }
  final LoginUsecase loginUsecase;
  final SignUpUsecase signUpUsecase;
  final ForgetPasswordUsecase forgetPasswordUsecase;
  final AccessTokenCacheUsecase accessTokenCacheUsecase;
  FutureOr<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loginRequestStatus: LoginRequestStatus.loading));
    final result = await loginUsecase(LoginParams(event.email, event.password));
    result.fold((l) {
      emit(state.copyWith(
          loginRequestStatus: LoginRequestStatus.error,
          errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(
          loginRequestStatus: LoginRequestStatus.loginSuccess,
          loginEntitie: r,
          errorMessage: ''));
      add(AccessTokenCacheEvent(r.token, true));
    });
  }

  FutureOr<void> _signup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(signUpRequestStatus: SignUpRequestStatus.loading));
    final result = await signUpUsecase(SignUpParams(
        confirmPassword: event.confirmPassword,
        email: event.email,
        password: event.password,
        name: event.name));
    result.fold((l) {
      emit(state.copyWith(
          signUpRequestStatus: SignUpRequestStatus.error,
          errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(
          signUpRequestStatus: SignUpRequestStatus.signUpSuccess,
          signupEtitie: r,
          errorMessage: ''));

      add(AccessTokenCacheEvent(r.token, false));
    });
  }

  FutureOr<void> _forgetPassword(
      ForgetPasswordEvent event, Emitter<AuthState> emit) async {
    final result =
        await forgetPasswordUsecase(ForgetPasswordParams(event.email));
    result.fold((l) {
      emit(state.copyWith(
          isEmailSent: false,
          forgetPasswordRequestStatus: ForgetPasswordRequestStatus.error,
          errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(
          forgetPasswordRequestStatus: ForgetPasswordRequestStatus.success,
          isEmailSent: true,
          errorMessage: ''));
    });
  }

  FutureOr<void> _cacheAccessToken(
      AccessTokenCacheEvent event, Emitter<AuthState> emit) async {
    final result = await accessTokenCacheUsecase(
        AccessTokenCacheParams(event.accessToken));
    if (event.isLogin) {
      result.fold(
        (l) => emit(
          state.copyWith(
            errorMessage: l.message,
            loginRequestStatus: LoginRequestStatus.error,
          ),
        ),
        (r) => emit(
          state.copyWith(
            errorMessage: '',
            loginRequestStatus: LoginRequestStatus.cachedSuccess,
          ),
        ),
      );
      ConstVar.accessToken = event.accessToken;
    } else {
      result.fold(
        (l) => emit(
          state.copyWith(
            errorMessage: l.message,
            signUpRequestStatus: SignUpRequestStatus.error,
          ),
        ),
        (r) => emit(
          state.copyWith(
            errorMessage: '',
            signUpRequestStatus: SignUpRequestStatus.cachedSuccess,
          ),
        ),
      );
      ConstVar.accessToken = event.accessToken;
    }
  }
}
