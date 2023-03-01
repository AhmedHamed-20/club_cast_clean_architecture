// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/follower_following_info_entite.dart';

class OtherUsersDataEntitie extends Equatable {
  final int result;
  final List<FollowerFollowigDataEntite> followerFollowigDataEntite;
  const OtherUsersDataEntitie(
      {required this.followerFollowigDataEntite, required this.result});

  OtherUsersDataEntitie copyWith({
    int? result,
    List<FollowerFollowigDataEntite>? followerFollowigDataEntite,
  }) {
    return OtherUsersDataEntitie(
      result: result ?? this.result,
      followerFollowigDataEntite:
          followerFollowigDataEntite ?? this.followerFollowigDataEntite,
    );
  }

  @override
  List<Object?> get props => [result, followerFollowigDataEntite];
}
