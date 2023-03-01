// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'followers_following_basic_data_entitie.dart';

class OtherUserFollowersFollowingDataEntitie extends Equatable {
  final int results;
  final List<OtherUserFollowersFollowingUserDataEntitie>
      otherUserFollowersFollowingUserDataEntitie;

  const OtherUserFollowersFollowingDataEntitie(
      {required this.results,
      required this.otherUserFollowersFollowingUserDataEntitie});

  OtherUserFollowersFollowingDataEntitie copyWith({
    int? results,
    List<OtherUserFollowersFollowingUserDataEntitie>?
        otherUserFollowersFollowingUserDataEntitie,
  }) {
    return OtherUserFollowersFollowingDataEntitie(
        results: results ?? this.results,
        otherUserFollowersFollowingUserDataEntitie:
            otherUserFollowersFollowingUserDataEntitie ??
                this.otherUserFollowersFollowingUserDataEntitie);
  }

  @override
  List<Object?> get props =>
      [results, otherUserFollowersFollowingUserDataEntitie];
}
