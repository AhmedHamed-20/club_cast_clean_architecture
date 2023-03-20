// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/follower_following_info_entity.dart';

class OtherUsersDataEntity extends Equatable {
  final int result;
  final List<FollowerFollowigDataEntity> followerFollowigDataEntite;
  const OtherUsersDataEntity(
      {required this.followerFollowigDataEntite, required this.result});

  OtherUsersDataEntity copyWith({
    int? result,
    List<FollowerFollowigDataEntity>? followerFollowigDataEntite,
  }) {
    return OtherUsersDataEntity(
      result: result ?? this.result,
      followerFollowigDataEntite:
          followerFollowigDataEntite ?? this.followerFollowigDataEntite,
    );
  }

  @override
  List<Object?> get props => [result, followerFollowigDataEntite];
}
