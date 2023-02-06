part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class RoomMessagesGetEvent extends ChatEvent {
  final String accessToken;
  final String roomId;

  const RoomMessagesGetEvent({required this.accessToken, required this.roomId});

  @override
  List<Object?> get props => [accessToken, roomId];
}

class RoomMessagesGetMoreEvent extends ChatEvent {
  final String accessToken;
  final String roomId;
  final int page;
  const RoomMessagesGetMoreEvent(
      {required this.accessToken, required this.roomId, required this.page});

  @override
  List<Object?> get props => [accessToken, roomId, page];
}

class MessageSendEvent extends ChatEvent {
  final String message;
  final bool isPublic;
  final String? toUserId;

  const MessageSendEvent(
      {required this.message, required this.isPublic, this.toUserId});

  @override
  List<Object?> get props => [message, isPublic, toUserId];
}

class MessageRemoveEvent extends ChatEvent {
  final String messageId;

  const MessageRemoveEvent({required this.messageId});

  @override
  List<Object?> get props => [messageId];
}

class ListenOnMessageSentSuccessEvent extends ChatEvent {
  final dynamic response;
  const ListenOnMessageSentSuccessEvent(this.response);
  @override
  List<Object?> get props => [response];
}

class ListenOnChatEventsEvent extends ChatEvent {
  const ListenOnChatEventsEvent();
  @override
  List<Object?> get props => [];
}

class ListenOnMessageRemovedEvent extends ChatEvent {
  final dynamic response;

  const ListenOnMessageRemovedEvent(this.response);
  @override
  List<Object?> get props => [response];
}

class LisenOnMessageRemoveSuccessEvent extends ChatEvent {
  final dynamic response;

  const LisenOnMessageRemoveSuccessEvent(this.response);
  @override
  List<Object?> get props => [response];
}

class ListenOnNewMessagesEvent extends ChatEvent {
  final dynamic response;

  const ListenOnNewMessagesEvent(this.response);
  @override
  List<Object?> get props => [response];
}

class LeaveChatRoomEvent extends ChatEvent {
  const LeaveChatRoomEvent();
  @override
  List<Object?> get props => [];
}
