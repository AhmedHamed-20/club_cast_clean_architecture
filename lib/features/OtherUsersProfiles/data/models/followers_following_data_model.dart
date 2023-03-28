import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/followers_following_basic_data_entity.dart';

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
  OtherUserFollowersFollowingDataEntity copyWith(
      {int? results,
      List<OtherUserFollowersFollowingUserDataEntity>?
          otherUserFollowersFollowingUserDataEntitie}) {
    return OtherUserFollowersFollowingDataModel(
        results: results ?? this.results,
        otherUserFollowersFollowingUserDataEntitie:
            otherUserFollowersFollowingUserDataEntitie ??
                this.otherUserFollowersFollowingUserDataEntitie);
  }

  @override
  Map<String, dynamic> toJson(bool isFollower) {
    Map<String, dynamic> usersData = {};
    for (var user in otherUserFollowersFollowingUserDataEntitie) {
      usersData.addAll(user.toJson());
    }
    if (isFollower) {
      return {
        'results': results,
        'data': [
          {'follower': usersData}
        ]
      };
    } else {
      return {
        'results': results,
        'data': [
          {'following': usersData}
        ]
      };
    }
  }

  @override
  List<Object?> get props =>
      [results, otherUserFollowersFollowingUserDataEntitie];
}
