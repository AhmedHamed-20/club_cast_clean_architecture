// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final RoomMessageEntitie roomMessageEntitie;
  final bool isEndOfMessages;
  final String errorMessage;
  final int statusCode;
  final RoomMessagesGetRequestStatus roomMessagesGetRequestStatus;
  const ChatState(
      {this.roomMessageEntitie =
          const RoomMessageEntitie(results: 0, roomMessages: []),
      this.isEndOfMessages = false,
      this.errorMessage = '',
      this.statusCode = 0,
      this.roomMessagesGetRequestStatus = RoomMessagesGetRequestStatus.idle});

  ChatState copyWith({
    RoomMessageEntitie? roomMessageEntitie,
    bool? isEndOfMessages,
    String? errorMessage,
    int? statusCode,
    RoomMessagesGetRequestStatus? roomMessagesGetRequestStatus,
  }) {
    return ChatState(
        statusCode: statusCode ?? this.statusCode,
        roomMessageEntitie: roomMessageEntitie ?? this.roomMessageEntitie,
        isEndOfMessages: isEndOfMessages ?? this.isEndOfMessages,
        errorMessage: errorMessage ?? this.errorMessage,
        roomMessagesGetRequestStatus:
            roomMessagesGetRequestStatus ?? this.roomMessagesGetRequestStatus);
  }

  @override
  List<Object> get props => [
        statusCode,
        roomMessageEntitie,
        isEndOfMessages,
        errorMessage,
        roomMessagesGetRequestStatus,
        identityHashCode(this),
      ];
}
