import '../../domain/entities/my_event_entitie.dart';

class MyEventsModel extends MyEventEntitie {
  const MyEventsModel(
      {required super.eventName,
      required super.eventDescription,
      required super.eventDate,
      required super.eventId});

  factory MyEventsModel.fromJson(Map<String, dynamic> json) {
    return MyEventsModel(
        eventName: json['name'],
        eventDescription: json['description'],
        eventDate: json['date'],
        eventId: json['_id']);
  }
}
