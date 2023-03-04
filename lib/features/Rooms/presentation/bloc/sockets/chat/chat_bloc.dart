import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/socket/socket_helper.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_message_entitie.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/usecases/get_room_messages.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/room_message_data_model.dart';
import '../../../../domain/entities/room_message_entitie_data.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this.roomMessagesGetUsecase) : super(const ChatState()) {
    on<RoomMessagesGetEvent>(_getRoomMessagesEvent);
    on<RoomMessagesGetMoreEvent>(_roomMessagesGetMoreEvent);
    on<ListenOnChatEventsEvent>(_listenOnChatEventsEvent);
    on<ListenOnMessageRemovedEvent>(_listenOnMessageRemovedEvent);
    on<ListenOnNewMessagesEvent>(_listenOnNewMessagesEvent);
    on<ListenOnMessageSentSuccessEvent>(_listenOnMessageSentSuccessEvent);
    on<LisenOnMessageRemoveSuccessEvent>(_listenOnMessageRemovedSuccessEvent);
    on<MessageSendEvent>(_sendMessageEvent);
    on<MessageRemoveEvent>(_removeMessageEvent);
    on<LeaveChatRoomEvent>(_leaveRoomEvent);
    on<ListenOnPrivateChatMessagesEvent>(_listenOnPrivateChatMessagesEvent);
    on<PrivateMessageSendEvent>(_sendPrivateMessageEvent);
    on<IncomingMessagesAllListClearEvent>(_clearAllIncomingMessagesListEvent);
    on<IncomingMessagesClearEvent>(_clearIcomingMessagesByUserIdEvent);
  }
  final RoomMessagesGetUsecase roomMessagesGetUsecase;
  FutureOr<void> _getRoomMessagesEvent(
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
        Map<String, List<RoomMessageDataEntitie>> privateChatMessages = {};
        for (var element in r.roomMessages) {
          if (element.isPublic == false) {
            if (privateChatMessages.containsKey(element.user!.id)) {
              privateChatMessages[element.user!.id]!.add(element);
            } else {
              privateChatMessages[element.user!.id] = [element];
            }
          }
        }
        emit(
          state.copyWith(
            errorMessage: '',
            statusCode: 0,
            privateChatMessages: privateChatMessages,
            isEndOfMessages: true,
            roomMessageEntitie: RoomMessageEntitie(
                results: r.results,
                roomMessages: r.roomMessages
                    .where(
                      (element) => element.isPublic,
                    )
                    .toList()),
            roomMessagesGetRequestStatus: RoomMessagesGetRequestStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: '',
            statusCode: 0,
            isEndOfMessages: false,
            roomMessageEntitie: RoomMessageEntitie(
                results: r.results,
                roomMessages: r.roomMessages
                    .where(
                      (element) => element.isPublic,
                    )
                    .toList()),
            roomMessagesGetRequestStatus: RoomMessagesGetRequestStatus.success,
          ),
        );
      }
    });
  }

  FutureOr<void> _roomMessagesGetMoreEvent(
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
          if (response['status'] == 'public') {
            add(ListenOnMessageRemovedEvent(
                response: response, isPrivate: false));
          } else {
            add(ListenOnMessageRemovedEvent(
                response: response, isPrivate: true));
          }
        });
    SocketHelper.listenOnMessageReceived(
        socket: ConstVar.socket,
        handler: (response) {
          if (response['status'] == 'public') {
            add(
              ListenOnNewMessagesEvent(response),
            );
          } else {
            add(
              ListenOnPrivateChatMessagesEvent(
                  response: response,
                  isMine: false,
                  userId: response['user']['_id']),
            );
          }
        });
    SocketHelper.listenOnMessageRemoveSuccess(
        socket: ConstVar.socket,
        handler: (response) {
          if (response['status'] == 'public') {
            add(LisenOnMessageRemoveSuccessEvent(
                response: response, isPrivate: false));
          } else {
            add(LisenOnMessageRemoveSuccessEvent(
                response: response, isPrivate: true));
          }
        });
  }

  FutureOr<void> _listenOnMessageRemovedEvent(
      ListenOnMessageRemovedEvent event, Emitter<ChatState> emit) {
    RoomMessageEntitie roomMessages = state.roomMessageEntitie;
    if (event.isPrivate) {
      Map<String, List<RoomMessageDataEntitie>>
          privateMessagesAfterRemoveMyMessage =
          Map.from(state.privateChatMessages!);
      privateMessagesAfterRemoveMyMessage[event.response['user']['_id']]!
          .removeWhere((element) => element.messageId == event.response['_id']);
      emit(
        state.copyWith(
          privateChatMessages: privateMessagesAfterRemoveMyMessage,
        ),
      );
    } else {
      emit(
        state.copyWith(
          roomMessageEntitie: roomMessages.copyWith(
            roomMessages: roomMessages.roomMessages
                .where((element) => element.messageId != event.response['_id'])
                .toList(),
          ),
        ),
      );
    }
  }

  FutureOr<void> _listenOnNewMessagesEvent(
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
    if (event.response['status'] == 'private') {
      add(ListenOnPrivateChatMessagesEvent(
          isMine: true,
          response: event.response,
          userId: event.response['to']['_id']));
      TextEditingControllers.roomChatPrivateMessageController.clear();
    } else {
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
  }

  FutureOr<void> _listenOnMessageRemovedSuccessEvent(
      LisenOnMessageRemoveSuccessEvent event, Emitter<ChatState> emit) {
    if (event.isPrivate) {
      Map<String, List<RoomMessageDataEntitie>>
          privateMessagesAfterRemoveMyMessage =
          Map.from(state.privateChatMessages!);
      privateMessagesAfterRemoveMyMessage[event.response['to']['_id']]!
          .removeWhere((element) => element.messageId == event.response['_id']);
      emit(
        state.copyWith(
          privateChatMessages: privateMessagesAfterRemoveMyMessage,
        ),
      );
    } else {
      RoomMessageEntitie roomMessages = state.roomMessageEntitie;
      emit(
        state.copyWith(
          roomMessageEntitie: roomMessages.copyWith(
            roomMessages: roomMessages.roomMessages
                .where((element) => element.messageId != event.response['_id'])
                .toList(),
          ),
        ),
      );
    }
  }

  FutureOr<void> _sendMessageEvent(
      MessageSendEvent event, Emitter<ChatState> emit) {
    SocketHelper.sendMessage(
        socket: ConstVar.socket,
        messageData: RoomMessageDataModel(
          isPublic: event.isPublic,
          message: event.message,
          toUserId: event.toUserId,
        ).toJsonPublicByDefault(isPublic: event.isPublic));
  }

  FutureOr<void> _removeMessageEvent(
      MessageRemoveEvent event, Emitter<ChatState> emit) {
    SocketHelper.removeMessage(
        socket: ConstVar.socket, messageId: event.messageId);
  }

  FutureOr<void> _leaveRoomEvent(
      LeaveChatRoomEvent event, Emitter<ChatState> emit) {
    emit(
      state.copyWith(
        currentTalkingToUserId: '',
        inComingPrivateChatMessages: const [],
        privateChatMessages: {},
        roomMessageEntitie: const RoomMessageEntitie(
          results: 0,
          roomMessages: [],
        ),
        roomMessagesGetRequestStatus: RoomMessagesGetRequestStatus.idle,
      ),
    );
  }

  FutureOr<void> _listenOnPrivateChatMessagesEvent(
      ListenOnPrivateChatMessagesEvent event, Emitter<ChatState> emit) {
    Map<String, List<RoomMessageDataEntitie>> privateRoomMessages =
        Map.from(state.privateChatMessages ?? {});
    if (privateRoomMessages == {}) {
      privateRoomMessages = {
        event.userId: [
          RoomMessageDataModel.fromJson(event.response, event.isMine)
        ]
      };
    } else if (privateRoomMessages.containsKey(event.userId)) {
      privateRoomMessages[event.userId]!
          .add(RoomMessageDataModel.fromJson(event.response, event.isMine));
    } else {
      privateRoomMessages[event.userId] = [
        RoomMessageDataModel.fromJson(event.response, event.isMine)
      ];
    }
    if (event.isMine == false) {
      List<RoomMessageDataEntitie> incommingPrivateChatMessages =
          List.from(state.inComingPrivateChatMessages);
      incommingPrivateChatMessages
          .add(RoomMessageDataModel.fromJson(event.response, event.isMine));
      emit(
        state.copyWith(
          inComingPrivateChatMessages: incommingPrivateChatMessages,
          privateChatMessages: privateRoomMessages,
        ),
      );
    } else {
      emit(
        state.copyWith(
          privateChatMessages: privateRoomMessages,
        ),
      );
    }
  }

  FutureOr<void> _sendPrivateMessageEvent(
      PrivateMessageSendEvent event, Emitter<ChatState> emit) {
    SocketHelper.sendMessage(
        socket: ConstVar.socket,
        messageData: RoomMessageDataModel(
          isPublic: false,
          message: event.message,
          toUserId: event.toUserId,
        ).toJsonPublicByDefault(isPublic: false, userId: event.toUserId));
    emit(state.copyWith(currentTalkingToUserId: event.toUserId));
  }

  void removeOverlayWidget(OverlayEntry overlayEntry) {
    overlayEntry.remove();
  }

  FutureOr<void> _clearAllIncomingMessagesListEvent(
      IncomingMessagesAllListClearEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(inComingPrivateChatMessages: const []));
  }

  FutureOr<void> _clearIcomingMessagesByUserIdEvent(
      IncomingMessagesClearEvent event, Emitter<ChatState> emit) {
    emit(
      state.copyWith(
        inComingPrivateChatMessages: List.from(state.inComingPrivateChatMessages
            .where((element) => element.user!.id != event.userId)
            .toList()),
      ),
    );
  }
}
