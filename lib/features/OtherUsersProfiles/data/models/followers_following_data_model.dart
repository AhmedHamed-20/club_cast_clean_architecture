import '../../domain/entities/followers_following_data_entity.dart';
import 'followers_following_basic_data_model.dart';

class OtherUserFollowersFollowingDataModel
    extends OtherUserFollowersFollowingDataEntity {
  const OtherUserFollowersFollowingDataModel({
    required super.results,
    required super.otherUserFollowersFollowingUserDataEntitie,
  });

  factory OtherUserFollowersFollowingDataModel.fromJson(
      Map<String, dynamic> json, bool isFollowers) {
    if (isFollowers) {
      return OtherUserFollowersFollowingDataModel(
        results: json['results'],
        otherUserFollowersFollowingUserDataEntitie: (json['data'] as List)
            .map((e) => OtherUserFollowersFollowingBasicDataModel.fromJson(
                e['follower']))
            .toList(),
      );
    } else {
      return OtherUserFollowersFollowingDataModel(
        results: json['results'],
        otherUserFollowersFollowingUserDataEntitie: (json['data'] as List)
            .map((e) => OtherUserFollowersFollowingBasicDataModel.fromJson(
                e['following']))
            .toList(),
      );
    }
  }

  @override
  List<Object?> get props =>
      [results, otherUserFollowersFollowingUserDataEntitie];
}
