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
