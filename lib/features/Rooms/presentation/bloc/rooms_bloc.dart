import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/all_rooms_entitie.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/usecases/get_all_rooms.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/default_values.dart';
import '../../../../core/routes/app_route_names.dart';
import '../../domain/entities/join_create_room_entitie.dart';
import '../../domain/usecases/get_room_by_room_id.dart';

part 'rooms_event.dart';
part 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  RoomsBloc(this.allRoomsGetUsecase, this.roomGetByRoomIdUseCase)
      : super(const RoomsState()) {
    on<AllRoomsGetEvent>(_getAllRooms);
    on<AllRoomsGetMoreEvent>(_getMoreRooms);
    on<RoomGetByRoomIdEvent>(_getRoomByRoomId);
  }
  final AllRoomsGetUsecase allRoomsGetUsecase;
  final RoomGetByRoomIdUseCase roomGetByRoomIdUseCase;
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

  void checkOnTabOnRoomCardLogic({
    JoinCreateRoomEntitie? joinCreateRoomEntitie,
    required String tabedCardRoomId,
    required BuildContext context,
    required bool isCreateRoom,
    required ChatBloc chatBloc,
    required SocketsVoiceBloc socketsVoiceBloc,
    required String accessToken,
    required String roomName,
  }) {
    if (joinCreateRoomEntitie == null ||
        joinCreateRoomEntitie == DefaultsValues.joinCreateRoomEntitieDefault) {
      socketsVoiceBloc.add(
        ConnectToSocketEvent(
          accessToken: accessToken,
          isCreateRoom: false,
          roomName: roomName,
        ),
      );
      flutterToast(
        msg: 'Joining room ...',
        backgroundColor: AppColors.toastWarning,
        textColor: AppColors.black,
      );
    } else if (tabedCardRoomId == joinCreateRoomEntitie.roomId) {
      Navigator.pushNamed(
        context,
        AppRoutesNames.roomScreen,
      );
    } else {
      if (isCreateRoom == true) {
        flutterToast(
          msg: 'You are admin in another room please leave it first',
          backgroundColor: AppColors.toastWarning,
          textColor: AppColors.black,
        );
      } else {
        socketsVoiceBloc.add(const LeaveRoomEvent());
        chatBloc.add(const LeaveChatRoomEvent());
        flutterToast(
          msg: 'Joining another room ...',
          backgroundColor: AppColors.toastWarning,
          textColor: AppColors.black,
        );
        socketsVoiceBloc.add(
          ConnectToSocketEvent(
            accessToken: ConstVar.accessToken,
            isCreateRoom: false,
            roomName: roomName,
          ),
        );
      }
    }
  }

  FutureOr<void> _getRoomByRoomId(
      RoomGetByRoomIdEvent event, Emitter<RoomsState> emit) async {
    emit(
      state.copyWith(
        privateRoomsGetRequestStatus: PrivateRoomsGetRequestStatus.loading,
      ),
    );
    final result = await roomGetByRoomIdUseCase(
      RoomGetByRoomIdParams(
        accessToken: event.accessToken,
        roomId: event.roomId,
      ),
    );

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            privateRoomsGetRequestStatus: PrivateRoomsGetRequestStatus.error)),
        (r) {
      emit(
        state.copyWith(
          errorMessage: '',
          statusCode: 0,
          privateRoomsGetRequestStatus: PrivateRoomsGetRequestStatus.success,
        ),
      );
      event.socketsVoiceBloc.add(
        ConnectToSocketEvent(
            accessToken: event.accessToken,
            isCreateRoom: false,
            roomName: r.name),
      );
    });
  }
}
