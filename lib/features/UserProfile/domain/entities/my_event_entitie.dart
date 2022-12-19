import '../../../../core/constants/base_event_entite/base_event_entitie.dart';

class MyEventEntitie extends BaseEventEntitie {
  const MyEventEntitie(
      {required super.eventName,
      required super.eventDescription,
      required super.eventDate});

  @override
  List<Object?> get props => [eventDate, eventDate, eventDescription];
}
