import 'package:equatable/equatable.dart';

abstract class BaseEventEntitie extends Equatable {
  final String eventName;
  final String eventDescription;
  final String eventDate;

  const BaseEventEntitie(
      {required this.eventName,
      required this.eventDescription,
      required this.eventDate});
}
