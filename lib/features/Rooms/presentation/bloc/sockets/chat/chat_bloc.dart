import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_message_entitie.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/usecases/get_room_messages.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this.roomMessagesGetUsecase) : super(const ChatState()) {
    on<RoomMessagesGetEvent>(_getRoomMessages);
    on<RoomMessagesGetMoreEvent>(_roomMessagesGetMore);
  }
  final RoomMessagesGetUsecase roomMessagesGetUsecase;
  FutureOr<void> _getRoomMessages(
      RoomMessagesGetEvent event, Emitter<ChatState> emit) async {
    emit(state.copyWith(
        roomMessagesGetRequestStatus: RoomMessagesGetRequestStatus.loading));
    final result = await roomMessagesGetUsecase(
      RoomMessagesGetParams(
        accessToken: event.accessToken,
        roomId: event.roomId,
        page: 1,
      ),
    );

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            isEndOfMessages: true,
            roomMessagesGetRequestStatus: RoomMessagesGetRequestStatus.error)),
        (r) {
      if (r.results <= 10) {
        emit(
          state.copyWith(
            errorMessage: '',
            statusCode: 0,
            isEndOfMessages: true,
            roomMessageEntitie: r,
            roomMessagesGetRequestStatus: RoomMessagesGetRequestStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: '',
            statusCode: 0,
            isEndOfMessages: false,
            roomMessageEntitie: r,
            roomMessagesGetRequestStatus: RoomMessagesGetRequestStatus.success,
          ),
        );
      }
    });
  }

  FutureOr<void> _roomMessagesGetMore(
      RoomMessagesGetMoreEvent event, Emitter<ChatState> emit) async {
    final result = await roomMessagesGetUsecase(
      RoomMessagesGetParams(
        accessToken: event.accessToken,
        roomId: event.roomId,
        page: event.page,
      ),
    );

    result.fold(
      (l) => emit(state.copyWith(
          errorMessage: l.message,
          statusCode: l.statusCode,
          isEndOfMessages: true,
          roomMessagesGetRequestStatus: RoomMessagesGetRequestStatus.error)),
      (r) {
        if (r.results == 0) {
          emit(state.copyWith(
            isEndOfMessages: true,
          ));
        } else if (r.results == 10) {
          RoomMessageEntitie roomMessageEntitie;
          roomMessageEntitie = state.roomMessageEntitie;

          roomMessageEntitie.roomMessages.addAll(r.roomMessages);

          emit(state.copyWith(
            errorMessage: '',
            statusCode: 0,
            roomMessageEntitie: roomMessageEntitie,
            isEndOfMessages: false,
          ));
        } else {
          RoomMessageEntitie roomMessageEntitie = state.roomMessageEntitie;
          roomMessageEntitie.roomMessages.addAll(r.roomMessages);
          emit(state.copyWith(
            errorMessage: '',
            statusCode: 0,
            roomMessageEntitie: roomMessageEntitie,
            isEndOfMessages: true,
          ));
        }
      },
    );
  }
}
