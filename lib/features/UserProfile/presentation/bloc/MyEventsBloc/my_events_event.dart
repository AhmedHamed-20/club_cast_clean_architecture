part of 'my_events_bloc.dart';

abstract class MyEventsEvent extends Equatable {
  const MyEventsEvent();
}

class MyEventsGetEvent extends MyEventsEvent {
  final String accessToken;
  final int page;
  const MyEventsGetEvent({required this.accessToken, required this.page});
  @override
  List<Object?> get props => [accessToken, page];
}

class EventCreateEvent extends MyEventsEvent {
  final String eventName;
  final String eventDescription;
  final String eventDate;
  final String accessToken;

  const EventCreateEvent(
      {required this.eventName,
      required this.eventDescription,
      required this.eventDate,
      required this.accessToken});

  @override
  List<Object?> get props =>
      [eventDate, eventDescription, eventName, accessToken];
}

class EventUpdateDataEvent extends MyEventsEvent {
  final String accessToken;
  final String eventId;
  final String eventName;
  final String eventDescription;
  final String eventDate;

  const EventUpdateDataEvent({
    required this.accessToken,
    required this.eventId,
    required this.eventName,
    required this.eventDescription,
    required this.eventDate,
  });

  @override
  List<Object?> get props => [
        accessToken,
        eventId,
        eventName,
        eventDescription,
        eventDate,
      ];
}

class EventRemoveEvent extends MyEventsEvent {
  final String accessToken;
  final String eventId;

  const EventRemoveEvent({required this.accessToken, required this.eventId});

  @override
  List<Object?> get props => [accessToken, eventId];
}

class MyEventsGetMoreEvent extends MyEventsEvent {
  final String accessToken;
  final int page;

  const MyEventsGetMoreEvent({required this.accessToken, required this.page});

  @override
  List<Object?> get props => [accessToken, page];
}
