import 'package:equatable/equatable.dart';

import 'other_user_events_data.dart';

class OtherUserEventsEntitie extends Equatable {
  final int results;
  final List<OtherUserEventDataEntite> events;

  const OtherUserEventsEntitie({required this.results, required this.events});

  @override
  List<Object?> get props => [results, events];
}
