import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_events_data_entitie.dart';

class MyEventsDataModel extends MyEventsDataEntitie {
  const MyEventsDataModel(
      {required super.eventName,
      required super.eventDescription,
      required super.eventDate,
      required super.eventId});

  factory MyEventsDataModel.fromJson(Map<String, dynamic> json) {
    return MyEventsDataModel(
        eventName: json['name'],
        eventDescription: json['description'],
        eventDate: json['date'],
        eventId: json['_id']);
  }
}
