import 'package:club_cast_clean_architecture/features/Auth/domain/entities/auth_entitie.dart';

class AuthModel extends AuthEntitie {
  const AuthModel(super.token);

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(json['token']);
  }
}
