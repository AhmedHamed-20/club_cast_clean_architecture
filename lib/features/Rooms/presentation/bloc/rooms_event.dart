part of 'rooms_bloc.dart';

abstract class RoomsEvent extends Equatable {
  const RoomsEvent();
}

class AllRoomsGetEvent extends RoomsEvent {
  final String accessToken;

  const AllRoomsGetEvent({required this.accessToken});

  @override
  List<Object?> get props => [accessToken];
}

class AllRoomsGetMoreEvent extends RoomsEvent {
  final String accessToken;
  final int page;

  const AllRoomsGetMoreEvent({required this.accessToken, required this.page});

  @override
  List<Object?> get props => [accessToken, page];
}

class RoomGetByRoomIdEvent extends RoomsEvent {
  final String accessToken;
  final String roomId;
  final SocketsVoiceBloc socketsVoiceBloc;
  final ChatBloc chatBloc;
  const RoomGetByRoomIdEvent(
      {required this.accessToken,
      required this.roomId,
      required this.socketsVoiceBloc,
      required this.chatBloc});

  @override
  List<Object?> get props => [accessToken, roomId, socketsVoiceBloc, chatBloc];
}
