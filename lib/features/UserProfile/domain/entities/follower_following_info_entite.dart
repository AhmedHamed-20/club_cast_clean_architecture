import '../../../../core/constants/base_user_info_entitie/basic_follower_data_entite.dart';

class FollowerFollowigDataEntite extends BaseFollowerFollowingDataEntite {
  const FollowerFollowigDataEntite(
      {required super.userName,
      required super.userPhoto,
      required super.userId,
      required super.isFollowed});

  @override
  List<Object?> get props => [userId, userName, userPhoto, isFollowed];
}
