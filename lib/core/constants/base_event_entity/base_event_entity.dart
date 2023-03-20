import 'package:equatable/equatable.dart';

abstract class BaseEventEntity extends Equatable {
  final String eventName;
  final String eventDescription;
  final String eventDate;
  final String eventId;
  const BaseEventEntity(
      {required this.eventName,
      required this.eventDescription,
      required this.eventDate,
      required this.eventId});
}
