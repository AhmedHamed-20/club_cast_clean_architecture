import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/socket/socket_helper.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_message_entitie.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/usecases/get_room_messages.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/room_message_data_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this.roomMessagesGetUsecase) : super(const ChatState()) {
    on<RoomMessagesGetEvent>(_getRoomMessages);
    on<RoomMessagesGetMoreEvent>(_roomMessagesGetMore);
    on<ListenOnChatEventsEvent>(_listenOnChatEventsEvent);
    on<ListenOnMessageRemovedEvent>(_listenOnMessageRemovedEvent);
    on<ListenOnNewMessagesEvent>(_listenOnNewMessages);
    on<ListenOnMessageSentSuccessEvent>(_listenOnMessageSentSuccessEvent);
    on<LisenOnMessageRemoveSuccessEvent>(_listenOnMessageRemovedSuccessEvent);
    on<MessageSendEvent>(_sendMessage);
    on<MessageRemoveEvent>(_removeMessage);
    on<LeaveChatRoomEvent>(_leaveRoom);
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
      add(const ListenOnChatEventsEvent());
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

  FutureOr<void> _listenOnChatEventsEvent(
      ListenOnChatEventsEvent event, Emitter<ChatState> emit) {
    SocketHelper.listenOnMessageSentSuccess(
        socket: ConstVar.socket,
        handler: (response) {
          add(ListenOnMessageSentSuccessEvent(response));
        });
    SocketHelper.listenOnMessageRemoved(
        socket: ConstVar.socket,
        handler: (response) {
          add(ListenOnMessageRemovedEvent(response));
        });
    SocketHelper.listenOnMessageReceived(
        socket: ConstVar.socket,
        handler: (response) {
          add(ListenOnNewMessagesEvent(response));
        });
    SocketHelper.listenOnMessageRemoveSuccess(
        socket: ConstVar.socket,
        handler: (response) {
          add(LisenOnMessageRemoveSuccessEvent(response));
        });
  }

  FutureOr<void> _listenOnMessageRemovedEvent(
      ListenOnMessageRemovedEvent event, Emitter<ChatState> emit) {}

  FutureOr<void> _listenOnNewMessages(
      ListenOnNewMessagesEvent event, Emitter<ChatState> emit) {
    RoomMessageEntitie roomMessages = state.roomMessageEntitie;

    emit(
      state.copyWith(
        roomMessageEntitie: roomMessages.copyWith(
          roomMessages: [
            ...roomMessages.roomMessages,
            RoomMessageDataModel.fromJson(event.response, false),
          ],
        ),
      ),
    );
  }

  FutureOr<void> _listenOnMessageSentSuccessEvent(
      ListenOnMessageSentSuccessEvent event, Emitter<ChatState> emit) {
    RoomMessageEntitie roomMessages = state.roomMessageEntitie;
    emit(
      state.copyWith(
        roomMessageEntitie: roomMessages.copyWith(
          roomMessages: [
            ...roomMessages.roomMessages,
            RoomMessageDataModel.fromJson(event.response, true),
          ],
        ),
      ),
    );
    TextEditingControllers.roomChatMessageController.clear();
  }

  FutureOr<void> _listenOnMessageRemovedSuccessEvent(
      LisenOnMessageRemoveSuccessEvent event, Emitter<ChatState> emit) {}

  FutureOr<void> _sendMessage(MessageSendEvent event, Emitter<ChatState> emit) {
    SocketHelper.sendMessage(
        socket: ConstVar.socket,
        messageData: RoomMessageDataModel(
          isPublic: event.isPublic,
          message: event.message,
          toUserId: event.toUserId,
        ).toJsonPublicByDefault());
  }

  FutureOr<void> _removeMessage(
      MessageRemoveEvent event, Emitter<ChatState> emit) {
    SocketHelper.removeMessage(
        socket: ConstVar.socket, messageId: event.messageId);
  }

  FutureOr<void> _leaveRoom(LeaveChatRoomEvent event, Emitter<ChatState> emit) {
    emit(
      state.copyWith(
        roomMessageEntitie:
            const RoomMessageEntitie(results: 0, roomMessages: []),
        roomMessagesGetRequestStatus: RoomMessagesGetRequestStatus.idle,
      ),
    );
  }
}
