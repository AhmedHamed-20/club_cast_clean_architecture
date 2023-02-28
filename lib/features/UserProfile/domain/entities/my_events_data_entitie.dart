import '../../../../core/constants/base_event_entite/base_event_entitie.dart';

class MyEventsDataEntitie extends BaseEventEntitie {
  const MyEventsDataEntitie(
      {required super.eventName,
      required super.eventDescription,
      required super.eventDate,
      required super.eventId});

  @override
  List<Object?> get props => [eventDate, eventDate, eventDescription, eventId];
}
