import 'package:club_cast_clean_architecture/core/constants/base_user_info_entitie/base_user_info_entity.dart';

class UpdatedUserDataInfoEntity extends BaseUserDataEntity {
  const UpdatedUserDataInfoEntity(
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
        followers,
        following,
        id,
        email,
        createdAt,
        bio,
      ];
}
