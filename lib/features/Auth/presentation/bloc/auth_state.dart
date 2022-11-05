part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isEmailSent;

  final AuthEntitie? loginEntitie;
  final AuthEntitie? signupEtitie;
  final ForgetPasswordRequestStatus forgetPasswordRequestStatus;

  final LoginRequestStatus loginRequestStatus;
  final String errorMessage;
  final SignUpRequestStatus signUpRequestStatus;
  const AuthState(
      {this.errorMessage = '',
      this.isEmailSent = false,
      this.loginEntitie,
      this.signupEtitie,
      this.forgetPasswordRequestStatus = ForgetPasswordRequestStatus.idle,
      this.loginRequestStatus = LoginRequestStatus.idle,
      this.signUpRequestStatus = SignUpRequestStatus.idle});

  AuthState copyWith(
      {bool? isEmailSent,
      AuthEntitie? loginEntitie,
      AuthEntitie? signupEtitie,
      LoginRequestStatus? loginRequestStatus,
      SignUpRequestStatus? signUpRequestStatus,
      String? errorMessage,
      ForgetPasswordRequestStatus? forgetPasswordRequestStatus}) {
    return AuthState(
        loginEntitie: loginEntitie ?? this.loginEntitie,
        signupEtitie: signupEtitie ?? this.signupEtitie,
        loginRequestStatus: loginRequestStatus ?? this.loginRequestStatus,
        signUpRequestStatus: signUpRequestStatus ?? this.signUpRequestStatus,
        isEmailSent: isEmailSent ?? this.isEmailSent,
        errorMessage: errorMessage ?? this.errorMessage,
        forgetPasswordRequestStatus:
            forgetPasswordRequestStatus ?? this.forgetPasswordRequestStatus);
  }

  @override
  List<Object?> get props => [
        isEmailSent,
        loginEntitie,
        signupEtitie,
        forgetPasswordRequestStatus,
        loginRequestStatus,
        errorMessage,
        signUpRequestStatus
      ];
}
