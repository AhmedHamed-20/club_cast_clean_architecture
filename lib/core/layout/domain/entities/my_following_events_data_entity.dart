import '../../../constants/base_event_entity/base_event_entity.dart';
import 'event_user_info.dart';

class MyFollowingEventsDataEntity extends BaseEventEntity {
  final EventUserInfoEntity userInfo;
  const MyFollowingEventsDataEntity(
      {required super.eventName,
      required super.eventDescription,
      required super.eventDate,
      required this.userInfo,
      required super.eventId});

  @override
  List<Object?> get props =>
      [eventId, userInfo, eventDate, eventName, eventDescription];
}
