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
}
