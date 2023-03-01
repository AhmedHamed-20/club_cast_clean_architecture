// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'other_user_events_data.dart';

class OtherUserEventsEntitie extends Equatable {
  final int results;
  final List<OtherUserEventDataEntite> events;

  const OtherUserEventsEntitie({required this.results, required this.events});

  OtherUserEventsEntitie copyWith({
    int? results,
    List<OtherUserEventDataEntite>? events,
  }) {
    return OtherUserEventsEntitie(
      results: results ?? this.results,
      events: events ?? this.events,
    );
  }

  @override
  List<Object?> get props => [results, events];
}
