import 'package:equatable/equatable.dart';

import 'followers_following_basic_data_entitie.dart';

class OtherUserFollowersFollowingDataEntitie extends Equatable {
  final int results;

  final List<OtherUserFollowersFollowingUserDataEntitie>
      otherUserFollowersFollowingUserDataEntitie;

  const OtherUserFollowersFollowingDataEntitie(
      {required this.results,
      required this.otherUserFollowersFollowingUserDataEntitie});

  @override
  List<Object?> get props =>
      [results, otherUserFollowersFollowingUserDataEntitie];
}
