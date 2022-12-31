import 'package:equatable/equatable.dart';

abstract class BaseEventEntitie extends Equatable {
  final String eventName;
  final String eventDescription;
  final String eventDate;
  final String eventId;
  const BaseEventEntitie(
      {required this.eventName,
      required this.eventDescription,
      required this.eventDate,
      required this.eventId});
}
