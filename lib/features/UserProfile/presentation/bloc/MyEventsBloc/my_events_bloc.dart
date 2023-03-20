import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utl/utls.dart';
import '../../../domain/entities/my_event_entity.dart';
import '../../../domain/usecases/events/create_event.dart';
import '../../../domain/usecases/events/get_my_events.dart';
import '../../../domain/usecases/events/remove_event.dart';
import '../../../domain/usecases/events/update_event.dart';

part 'my_events_event.dart';
part 'my_events_state.dart';

class MyEventsBloc extends Bloc<MyEventsEvent, MyEventsState> {
  MyEventsBloc(this.myEventsGetUsecase, this.eventCreateUseCase,
      this.eventUpdateUsecase, this.eventRemoveUsecase)
      : super(const MyEventsState()) {
    on<MyEventsGetEvent>(_getMyEvents);
    on<EventCreateEvent>(_createEvent);
    on<EventUpdateDataEvent>(_updateEvent);
    on<EventRemoveEvent>(_removeEvent);
    on<MyEventsGetMoreEvent>(_myEventsGetMore);
  }
  final MyEventsGetUsecase myEventsGetUsecase;
  final EventCreateUseCase eventCreateUseCase;
  final EventUpdateUsecase eventUpdateUsecase;
  final EventRemoveUsecase eventRemoveUsecase;

  FutureOr<void> _getMyEvents(
      MyEventsGetEvent event, Emitter<MyEventsState> emit) async {
    final result = await myEventsGetUsecase(
        MyEventsParams(accessToken: event.accessToken, page: 1));
    result.fold(
      (l) => emit(state.copyWith(
          statusCode: l.statusCode,
          errorMessages: l.message,
          myEventRequestStatus: UserDataGetRequestStatus.error)),
      (r) => emit(
        state.copyWith(
            errorMessages: '',
            statusCode: 0,
            myEvents: r,
            isEndOfMyEventsData: r.results < 10 ? true : false,
            myEventRequestStatus: UserDataGetRequestStatus.success),
      ),
    );
  }

  FutureOr<void> _createEvent(
      EventCreateEvent event, Emitter<MyEventsState> emit) async {
    emit(state.copyWith(
        eventCreateRequestStatus: EventCreateRequestStatus.loading));
    final result = await eventCreateUseCase(EventCreateParams(
      accessToken: event.accessToken,
      eventName: event.eventName,
      eventDescription: event.eventDescription,
      eventDate: event.eventDate,
    ));

    result.fold(
        (l) => emit(state.copyWith(
            statusCode: l.statusCode,
            errorMessages: l.message,
            eventCreateRequestStatus: EventCreateRequestStatus.error)), (r) {
      emit(state.copyWith(
          errorMessages: '',
          statusCode: 0,
          eventCreateRequestStatus: EventCreateRequestStatus.success));
      add(MyEventsGetEvent(accessToken: event.accessToken, page: 1));
    });
  }

  FutureOr<void> _updateEvent(
      EventUpdateDataEvent event, Emitter<MyEventsState> emit) async {
    emit(state.copyWith(
        myEventUpdateRequestStatus: MyDataUpdateRequestStatus.loading));
    final result = await eventUpdateUsecase(EventUpdateUsecaseParams(
        accessToken: event.accessToken,
        eventDescription: event.eventDescription,
        eventName: event.eventName,
        eventID: event.eventId,
        eventDate: event.eventDate));

    result.fold(
        (l) => emit(state.copyWith(
            statusCode: l.statusCode,
            errorMessages: l.message,
            myEventUpdateRequestStatus: MyDataUpdateRequestStatus.error)), (r) {
      emit(state.copyWith(
          errorMessages: '',
          statusCode: 0,
          myEventUpdateRequestStatus: MyDataUpdateRequestStatus.updated));
      add(MyEventsGetEvent(accessToken: event.accessToken, page: 1));
    });
  }

  FutureOr<void> _removeEvent(
      EventRemoveEvent event, Emitter<MyEventsState> emit) async {
    emit(state.copyWith(
        myEventRemoveRequestStatus: MyDataRemoveRequestStatus.loading));
    final result = await eventRemoveUsecase(EventRemoveUsecaseParams(
        accessToken: event.accessToken, eventID: event.eventId));

    result.fold(
        (l) => emit(state.copyWith(
            statusCode: l.statusCode,
            errorMessages: l.message,
            myEventRemoveRequestStatus: MyDataRemoveRequestStatus.error)), (r) {
      emit(state.copyWith(
          statusCode: 0,
          errorMessages: '',
          myEventRemoveRequestStatus: MyDataRemoveRequestStatus.removed));
      add(MyEventsGetEvent(accessToken: event.accessToken, page: 1));
    });
  }

  FutureOr<void> _myEventsGetMore(
      MyEventsGetMoreEvent event, Emitter<MyEventsState> emit) async {
    final result = await myEventsGetUsecase(
        MyEventsParams(accessToken: event.accessToken, page: event.page));

    result.fold(
        (l) => emit(state.copyWith(
            statusCode: l.statusCode,
            errorMessages: l.message,
            isEndOfMyEventsData: true)), (r) {
      if (r.results == 0) {
        emit(state.copyWith(
          isEndOfMyEventsData: true,
        ));
      } else if (r.results == 10) {
        MyEventsEntity myEventsEntitie;
        myEventsEntitie = state.myEvents;

        myEventsEntitie.myEventsDataEntitie.addAll(r.myEventsDataEntitie);

        emit(state.copyWith(
          errorMessages: '',
          statusCode: 0,
          myEvents: myEventsEntitie.copyWith(),
          isEndOfMyEventsData: false,
        ));
      } else {
        MyEventsEntity myEventsEntitie = state.myEvents;
        myEventsEntitie.myEventsDataEntitie.addAll(r.myEventsDataEntitie);
        emit(state.copyWith(
          errorMessages: '',
          myEvents: myEventsEntitie.copyWith(),
          isEndOfMyEventsData: true,
        ));
      }
    });
  }
}
