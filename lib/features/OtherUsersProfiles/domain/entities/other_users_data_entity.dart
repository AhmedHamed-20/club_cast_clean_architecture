import 'package:club_cast_clean_architecture/core/constants/base_user_info_entitie/base_user_info_entity.dart';

abstract class OtherUserDataEntity extends BaseUserDataEntity {
  final bool isFollowing;
  const OtherUserDataEntity(
      {required super.userName,
      required super.userPhoto,
      required super.followers,
      required super.following,
      required super.id,
      required this.isFollowing,
      required super.email,
      required super.createdAt,
      required super.bio});

  Map<String, dynamic> toJson();
}
