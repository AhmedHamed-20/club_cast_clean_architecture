import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/all_rooms_entitie.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/usecases/get_all_rooms.dart';
import 'package:equatable/equatable.dart';

part 'rooms_event.dart';
part 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  RoomsBloc(this.allRoomsGetUsecase) : super(const RoomsState()) {
    on<AllRoomsGetEvent>(_getAllRooms);
    on<AllRoomsGetMoreEvent>(_getMoreRooms);
  }
  final AllRoomsGetUsecase allRoomsGetUsecase;
  FutureOr<void> _getAllRooms(
      AllRoomsGetEvent event, Emitter<RoomsState> emit) async {
    if (state.allRoomsGetRequestStatus != AllRoomsGetRequestStatus.loading) {
      emit(state.copyWith(
          allRoomsGetRequestStatus: AllRoomsGetRequestStatus.loading));
    }
    final result = await allRoomsGetUsecase(
        AllRoomsGetParams(accessToken: event.accessToken, page: 1));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            isEndOfRoomsData: true,
            allRoomsGetRequestStatus: AllRoomsGetRequestStatus.error)), (r) {
      if (r.results <= 10) {
        emit(state.copyWith(
            isEndOfRoomsData: true,
            errorMessage: '',
            statusCode: 0,
            allRoomsGetRequestStatus: AllRoomsGetRequestStatus.success,
            allRoomsEntitie: r));
      } else {
        emit(state.copyWith(
            isEndOfRoomsData: false,
            errorMessage: '',
            statusCode: 0,
            allRoomsGetRequestStatus: AllRoomsGetRequestStatus.success,
            allRoomsEntitie: r));
      }
    });
  }

  FutureOr<void> _getMoreRooms(
      AllRoomsGetMoreEvent event, Emitter<RoomsState> emit) async {
    final result = await allRoomsGetUsecase(
        AllRoomsGetParams(accessToken: event.accessToken, page: event.page));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            isEndOfRoomsData: true,
            allRoomsGetRequestStatus: AllRoomsGetRequestStatus.error)), (r) {
      if (r.results == 0) {
        emit(state.copyWith(
          isEndOfRoomsData: true,
        ));
      } else if (r.results == 10) {
        AllRoomsEntitie allRoomsEntitie;
        allRoomsEntitie = state.allRoomsEntitie!;

        allRoomsEntitie.allRoomsDataEntitie.addAll(r.allRoomsDataEntitie);

        emit(state.copyWith(
          errorMessage: '',
          statusCode: 0,
          allRoomsEntitie: allRoomsEntitie,
          isEndOfRoomsData: false,
        ));
      } else {
        AllRoomsEntitie allRoomsEntitie = state.allRoomsEntitie!;
        allRoomsEntitie.allRoomsDataEntitie.addAll(r.allRoomsDataEntitie);
        emit(state.copyWith(
          errorMessage: '',
          allRoomsEntitie: allRoomsEntitie,
          isEndOfRoomsData: true,
        ));
      }
    });
  }
}
