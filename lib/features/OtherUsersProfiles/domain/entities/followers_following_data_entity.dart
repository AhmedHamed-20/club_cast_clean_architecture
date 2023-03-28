// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'followers_following_basic_data_entity.dart';

abstract class OtherUserFollowersFollowingDataEntity extends Equatable {
  final int results;
  final List<OtherUserFollowersFollowingUserDataEntity>
      otherUserFollowersFollowingUserDataEntitie;

  const OtherUserFollowersFollowingDataEntity(
      {required this.results,
      required this.otherUserFollowersFollowingUserDataEntitie});

  OtherUserFollowersFollowingDataEntity copyWith({
    int? results,
    List<OtherUserFollowersFollowingUserDataEntity>?
        otherUserFollowersFollowingUserDataEntitie,
  });

  Map<String, dynamic> toJson(bool isFollower);
}
