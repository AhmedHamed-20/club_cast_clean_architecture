import 'package:club_cast_clean_architecture/core/layout/domain/entities/my_following_events_data_entitie.dart';

import 'event_user_info_model.dart';

class MyFollowingEventsDataModel extends MyFollowingEventsDataEntitie {
  const MyFollowingEventsDataModel(
      {required super.eventName,
      required super.eventDescription,
      required super.eventDate,
      required super.userInfo,
      required super.eventId});

  factory MyFollowingEventsDataModel.fromJson(Map<String, dynamic> json) {
    return MyFollowingEventsDataModel(
      eventName: json['name'],
      eventDescription: json['description'],
      eventDate: json['date'],
      eventId: json['_id'],
      userInfo: EventUserInfoModel.fromJson(json['createdBy']),
    );
  }
}
