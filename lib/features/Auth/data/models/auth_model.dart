import 'package:club_cast_clean_architecture/features/Auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel(super.token);

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(json['token'] as String);
  }
}
