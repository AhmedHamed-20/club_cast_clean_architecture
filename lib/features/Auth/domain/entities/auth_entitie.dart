import 'package:equatable/equatable.dart';

class AuthEntitie extends Equatable {
  final String token;

  const AuthEntitie(this.token);

  @override
  List<Object?> get props => [token];
}
