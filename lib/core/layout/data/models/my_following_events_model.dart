import 'package:club_cast_clean_architecture/core/layout/data/models/event_user_info_model.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/my_following_events_entitie.dart';

class MyFollowingEventsModel extends MyFollowingEventsEntitie {
  const MyFollowingEventsModel(
      {required super.eventName,
      required super.eventDescription,
      required super.eventDate,
      required super.userInfo});

  factory MyFollowingEventsModel.fromJson(Map<String, dynamic> json) {
    return MyFollowingEventsModel(
      eventName: json['name'],
      eventDescription: json['description'],
      eventDate: json['date'],
      userInfo: EventUserInfoModel.fromJson(json['createdBy']),
    );
  }
}
