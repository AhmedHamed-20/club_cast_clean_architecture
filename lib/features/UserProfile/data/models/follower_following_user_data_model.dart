import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/follower_following_info_entite.dart';

class FollowerFollowingUserDataModel extends FollowerFollowigDataEntite {
  const FollowerFollowingUserDataModel(
      {required super.userName,
      required super.userPhoto,
      required super.userId,
      required super.isFollowed});

  factory FollowerFollowingUserDataModel.fromJson(Map<String, dynamic> json) {
    if (json['follower'] != null) {
      return FollowerFollowingUserDataModel(
          userName: json['follower']['name'],
          userPhoto: json['follower']['photo'],
          userId: json['follower']['_id'],
          isFollowed: json['follower']['isFollowed']);
    } else {
      return FollowerFollowingUserDataModel(
          userName: json['following']['name'],
          userPhoto: json['following']['photo'],
          userId: json['following']['_id'],
          isFollowed: json['following']['isFollowed']);
    }
  }
}
