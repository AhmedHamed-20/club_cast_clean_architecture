// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'my_following_events_data_entitie.dart';

class MyFollowingEventsEntitie extends Equatable {
  final int results;
  final List<MyFollowingEventsDataEntitie> myFollowingEventsDataEntitie;
  const MyFollowingEventsEntitie(
      {required this.results, required this.myFollowingEventsDataEntitie});

  MyFollowingEventsEntitie copyWith({
    int? results,
    List<MyFollowingEventsDataEntitie>? myFollowingEventsDataEntitie,
  }) {
    return MyFollowingEventsEntitie(
      results: results ?? this.results,
      myFollowingEventsDataEntitie:
          myFollowingEventsDataEntitie ?? this.myFollowingEventsDataEntitie,
    );
  }

  @override
  List<Object?> get props => [
        myFollowingEventsDataEntitie,
        results,
      ];
}
