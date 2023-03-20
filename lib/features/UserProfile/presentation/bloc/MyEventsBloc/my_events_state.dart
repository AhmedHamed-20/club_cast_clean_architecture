// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_events_bloc.dart';

class MyEventsState extends Equatable {
  final String errorMessages;
  final int statusCode;
  final EventCreateRequestStatus eventCreateRequestStatus;
  final MyEventsEntity myEvents;
  final bool isEndOfMyEventsData;
  final UserDataGetRequestStatus myEventRequestStatus;
  final MyDataRemoveRequestStatus myEventRemoveRequestStatus;
  final MyDataUpdateRequestStatus myEventUpdateRequestStatus;

  const MyEventsState({
    this.errorMessages = '',
    this.statusCode = 0,
    this.eventCreateRequestStatus = EventCreateRequestStatus.idle,
    this.myEvents = const MyEventsEntity(myEventsDataEntitie: [], results: 0),
    this.isEndOfMyEventsData = false,
    this.myEventRequestStatus = UserDataGetRequestStatus.loading,
    this.myEventRemoveRequestStatus = MyDataRemoveRequestStatus.idle,
    this.myEventUpdateRequestStatus = MyDataUpdateRequestStatus.idle,
  });

  MyEventsState copyWith({
    String? errorMessages,
    int? statusCode,
    EventCreateRequestStatus? eventCreateRequestStatus,
    MyEventsEntity? myEvents,
    bool? isEndOfMyEventsData,
    UserDataGetRequestStatus? myEventRequestStatus,
    MyDataRemoveRequestStatus? myEventRemoveRequestStatus,
    MyDataUpdateRequestStatus? myEventUpdateRequestStatus,
  }) {
    return MyEventsState(
      errorMessages: errorMessages ?? this.errorMessages,
      statusCode: statusCode ?? this.statusCode,
      eventCreateRequestStatus:
          eventCreateRequestStatus ?? this.eventCreateRequestStatus,
      myEvents: myEvents ?? this.myEvents,
      isEndOfMyEventsData: isEndOfMyEventsData ?? this.isEndOfMyEventsData,
      myEventRequestStatus: myEventRequestStatus ?? this.myEventRequestStatus,
      myEventRemoveRequestStatus:
          myEventRemoveRequestStatus ?? this.myEventRemoveRequestStatus,
      myEventUpdateRequestStatus:
          myEventUpdateRequestStatus ?? this.myEventUpdateRequestStatus,
    );
  }

  @override
  List<Object> get props => [
        errorMessages,
        myEventUpdateRequestStatus,
        myEventRequestStatus,
        statusCode,
        eventCreateRequestStatus,
        myEvents,
        isEndOfMyEventsData,
        myEventRemoveRequestStatus,
      ];
}
