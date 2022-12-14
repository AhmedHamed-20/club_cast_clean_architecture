import '../../../constants/base_user_info_entitie/base_user_info_entite.dart';

class UserDataEntitie extends BaseUserDataEntitie {
  const UserDataEntitie(
      {required super.userName,
      required super.userPhoto,
      required super.followers,
      required super.following,
      required super.uid,
      required super.email,
      required super.createdAt,
      required super.bio});

  @override
  List<Object?> get props => [
        userName,
        userPhoto,
        uid,
        followers,
        following,
        email,
        createdAt,
        bio,
      ];
}
