import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String token;

  const AuthEntity(this.token);

  @override
  List<Object?> get props => [token];
}
