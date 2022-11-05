part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignupEvent extends AuthEvent {
  final String name;
  final String confirmPassword;
  final String email;
  final String password;

  const SignupEvent(this.email, this.password, this.confirmPassword, this.name);

  @override
  List<Object?> get props => [email, password, confirmPassword, name];
}

class ForgetPasswordEvent extends AuthEvent {
  final String email;

  const ForgetPasswordEvent(this.email);

  @override
  List<Object?> get props => [email];
}
