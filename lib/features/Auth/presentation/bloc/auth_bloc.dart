import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/entities/auth_entitie.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/forget_password.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/login.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/sign_up.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.forgetPasswordUsecase, this.loginUsecase, this.signUpUsecase)
      : super(const AuthState()) {
    on<LoginEvent>(_login);
    on<SignupEvent>(_signup);
    on<ForgetPasswordEvent>(_forgetPassword);
  }
  LoginUsecase loginUsecase;
  SignUpUsecase signUpUsecase;
  ForgetPasswordUsecase forgetPasswordUsecase;
  FutureOr<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    final result = await loginUsecase(LoginParams(event.email, event.password));
    result.fold((l) {
      emit(state.copyWith(
          loginRequestStatus: LoginRequestStatus.error,
          errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(
          loginRequestStatus: LoginRequestStatus.success,
          loginEntitie: r,
          errorMessage: ''));
    });
  }

  FutureOr<void> _signup(SignupEvent event, Emitter<AuthState> emit) async {
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
          signUpRequestStatus: SignUpRequestStatus.success,
          signupEtitie: r,
          errorMessage: ''));
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
}
