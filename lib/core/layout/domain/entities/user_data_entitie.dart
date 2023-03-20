import '../../../constants/base_user_info_entitie/base_user_info_entity.dart';

class UserDataEntitie extends BaseUserDataEntity {
  const UserDataEntitie(
      {required super.userName,
      required super.userPhoto,
      required super.followers,
      required super.following,
      required super.id,
      required super.email,
      required super.createdAt,
      required super.bio});

  @override
  List<Object?> get props => [
        userName,
        userPhoto,
        id,
        followers,
        following,
        email,
        createdAt,
        bio,
      ];
}
