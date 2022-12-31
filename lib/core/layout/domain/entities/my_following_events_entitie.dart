import '../../../constants/base_event_entite/base_event_entitie.dart';
import 'event_user_info.dart';

class MyFollowingEventsEntitie extends BaseEventEntitie {
  final EventUserInfoEntitie userInfo;
  const MyFollowingEventsEntitie(
      {required super.eventName,
      required super.eventDescription,
      required super.eventDate,
      required this.userInfo,
      required super.eventId});

  @override
  List<Object?> get props =>
      [eventId, userInfo, eventDate, eventName, eventDescription];
}
