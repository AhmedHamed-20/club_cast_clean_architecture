import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_events_data.dart';

class OtherUserEventsDataModel extends OtherUserEventDataEntity {
  const OtherUserEventsDataModel(
      {required super.eventName,
      required super.eventDescription,
      required super.eventDate,
      required super.eventId});

  factory OtherUserEventsDataModel.fromJson(Map<String, dynamic> json) {
    return OtherUserEventsDataModel(
        eventName: json['name'],
        eventDescription: json['description'],
        eventDate: json['date'],
        eventId: json['_id']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': eventName,
      'description': eventDescription,
      'date': eventDate,
      '_id': eventId,
    };
  }

  @override
  List<Object?> get props => [eventName, eventDescription, eventDate, eventId];
}
