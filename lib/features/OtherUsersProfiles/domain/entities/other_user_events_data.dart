import 'package:club_cast_clean_architecture/core/constants/base_event_entity/base_event_entity.dart';

class OtherUserEventDataEntity extends BaseEventEntity {
  const OtherUserEventDataEntity(
      {required super.eventName,
      required super.eventDescription,
      required super.eventDate,
      required super.eventId});

  @override
  List<Object?> get props => [eventName, eventDescription, eventDate, eventId];
}
