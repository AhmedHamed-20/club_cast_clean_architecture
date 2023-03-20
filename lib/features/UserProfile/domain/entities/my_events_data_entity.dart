import '../../../../core/constants/base_event_entity/base_event_entity.dart';

class MyEventsDataEntity extends BaseEventEntity {
  const MyEventsDataEntity(
      {required super.eventName,
      required super.eventDescription,
      required super.eventDate,
      required super.eventId});

  @override
  List<Object?> get props => [eventDate, eventDate, eventDescription, eventId];
}
