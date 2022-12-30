import 'package:club_cast_clean_architecture/features/UserProfile/data/models/follower_following_user_data_model.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/other_users_basic_info_entitie.dart';

class OtherUsersDataModel extends OtherUsersDataEntitie {
  const OtherUsersDataModel({
    required super.followerFollowigDataEntite,
    required super.result,
  });

  factory OtherUsersDataModel.fromJson(Map<String, dynamic> json) {
    return OtherUsersDataModel(
        followerFollowigDataEntite: (json['data'] as List)
            .map((e) => FollowerFollowingUserDataModel.fromJson(e))
            .toList(),
        result: json['results']);
  }
}
