import 'package:club_cast_clean_architecture/core/constants/base_user_info_entitie/base_user_info_entite.dart';

class OtherUserDataEntitie extends BaseUserDataEntitie {
  final bool isFollowing;
  const OtherUserDataEntitie(
      {required super.userName,
      required super.userPhoto,
      required super.followers,
      required super.following,
      required super.uid,
      required this.isFollowing,
      required super.email,
      required super.createdAt,
      required super.bio});

  @override
  List<Object?> get props => [
        userName,
        userPhoto,
        isFollowing,
        followers,
        following,
        uid,
        email,
        createdAt,
        bio
      ];
}
