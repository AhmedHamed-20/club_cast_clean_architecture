import 'package:equatable/equatable.dart';

import 'my_following_events_data_entitie.dart';

class MyFollowingEventsEntitie extends Equatable {
  final int results;
  final List<MyFollowingEventsDataEntitie> myFollowingEventsDataEntitie;
  const MyFollowingEventsEntitie(
      {required this.results, required this.myFollowingEventsDataEntitie});

  @override
  List<Object?> get props => [
        myFollowingEventsDataEntitie,
        results,
      ];
}
