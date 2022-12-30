import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/follower_following_info_entite.dart';
import 'package:equatable/equatable.dart';

class OtherUsersDataEntitie extends Equatable {
  final int result;
  final List<FollowerFollowigDataEntite> followerFollowigDataEntite;
  const OtherUsersDataEntitie(
      {required this.followerFollowigDataEntite, required this.result});

  @override
  List<Object?> get props => [result, followerFollowigDataEntite];
}
