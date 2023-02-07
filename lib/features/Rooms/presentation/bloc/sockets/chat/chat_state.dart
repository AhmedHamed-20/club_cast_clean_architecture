// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final RoomMessageEntitie roomMessageEntitie;
  final Map<String, List<RoomMessageDataEntitie>>? privateChatMessages;

  final bool isEndOfMessages;
  final String errorMessage;
  final int statusCode;
  final RoomMessagesGetRequestStatus roomMessagesGetRequestStatus;
  final String currentTalkingToUserId;
  const ChatState(
      {this.roomMessageEntitie =
          const RoomMessageEntitie(results: 0, roomMessages: []),
      this.isEndOfMessages = false,
      this.errorMessage = '',
      this.statusCode = 0,
      this.currentTalkingToUserId = '',
      this.roomMessagesGetRequestStatus = RoomMessagesGetRequestStatus.idle,
      this.privateChatMessages});

  ChatState copyWith({
    String? currentTalkingToUserId,
    RoomMessageEntitie? roomMessageEntitie,
    bool? isEndOfMessages,
    String? errorMessage,
    int? statusCode,
    Map<String, List<RoomMessageDataEntitie>>? privateChatMessages,
    RoomMessagesGetRequestStatus? roomMessagesGetRequestStatus,
  }) {
    return ChatState(
        currentTalkingToUserId:
            currentTalkingToUserId ?? this.currentTalkingToUserId,
        statusCode: statusCode ?? this.statusCode,
        roomMessageEntitie: roomMessageEntitie ?? this.roomMessageEntitie,
        isEndOfMessages: isEndOfMessages ?? this.isEndOfMessages,
        errorMessage: errorMessage ?? this.errorMessage,
        roomMessagesGetRequestStatus:
            roomMessagesGetRequestStatus ?? this.roomMessagesGetRequestStatus,
        privateChatMessages: privateChatMessages ?? this.privateChatMessages);
  }

  @override
  List<Object?> get props => [
        statusCode,
        roomMessageEntitie,
        isEndOfMessages,
        errorMessage,
        roomMessagesGetRequestStatus,
        privateChatMessages,
        currentTalkingToUserId,
        identityHashCode(this),
      ];
}
