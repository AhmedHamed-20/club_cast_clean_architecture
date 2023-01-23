import 'package:club_cast_clean_architecture/core/constants/base_event_entite/base_event_entitie.dart';

class OtherUserEventDataEntite extends BaseEventEntitie {
  const OtherUserEventDataEntite(
      {required super.eventName,
      required super.eventDescription,
      required super.eventDate,
      required super.eventId});

  @override
  List<Object?> get props => [eventName, eventDescription, eventDate, eventId];
}
