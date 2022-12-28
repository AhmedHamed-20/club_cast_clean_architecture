import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/follower_following_info_entite.dart';

class FollowerFollowingUserDataModel extends FollowerFollowigDataEntite {
  const FollowerFollowingUserDataModel(
      {required super.userName,
      required super.userPhoto,
      required super.userId,
      required super.isFollowed});

  factory FollowerFollowingUserDataModel.fromJson(Map<String, dynamic> json) {
    return FollowerFollowingUserDataModel(
        userName: json['follower']['name'] ?? json['following']['name'],
        userPhoto: json['follower']['photo'] ?? json['following']['photo'],
        userId: json['follower']['_id'] ?? json['following']['_id'],
        isFollowed:
            json['follower']['isFollowed'] ?? json['following']['isFollowed']);
  }
}
