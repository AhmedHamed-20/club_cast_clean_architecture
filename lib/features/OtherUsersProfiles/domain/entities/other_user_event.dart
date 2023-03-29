// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'other_user_events_data.dart';

abstract class OtherUserEventsEntity extends Equatable {
  final int results;
  final List<OtherUserEventDataEntity> events;

  const OtherUserEventsEntity({required this.results, required this.events});

  OtherUserEventsEntity copyWith({
    int? results,
    List<OtherUserEventDataEntity>? events,
  });

  Map<String, dynamic> toJson();
}
