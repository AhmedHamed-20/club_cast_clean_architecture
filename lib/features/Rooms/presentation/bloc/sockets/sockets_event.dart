part of 'sockets_bloc.dart';

abstract class SocketsEvent extends Equatable {
  const SocketsEvent();
}

class ConnectToSocketEvent extends SocketsEvent {
  final String accessToken;

  const ConnectToSocketEvent(this.accessToken);

  @override
  List<Object> get props => [accessToken];
}

class JoinRoomEvent extends SocketsEvent {
  final String roomName;

  const JoinRoomEvent(this.roomName);

  @override
  List<Object> get props => [roomName];
}

class ConnectToSocketsSuccessEvent extends SocketsEvent {
  const ConnectToSocketsSuccessEvent();

  @override
  List<Object?> get props => [];
}

class JoinRoomSuccessEvent extends SocketsEvent {
  final dynamic response;
  const JoinRoomSuccessEvent(this.response);

  @override
  List<Object?> get props => [response];
}

class UserJoinedEvent extends SocketsEvent {
  final dynamic response;
  const UserJoinedEvent(this.response);

  @override
  List<Object?> get props => [response];
}

class UserLeftEvent extends SocketsEvent {
  final dynamic response;
  const UserLeftEvent(this.response);

  @override
  List<Object?> get props => [response];
}

class AdminLeftEvent extends SocketsEvent {
  final dynamic response;
  const AdminLeftEvent(this.response);

  @override
  List<Object?> get props => [response];
}

class RoomEndedEvent extends SocketsEvent {
  final dynamic response;
  const RoomEndedEvent(this.response);

  @override
  List<Object?> get props => [response];
}

class UserChangedToAudienceEvent extends SocketsEvent {
  final dynamic response;
  const UserChangedToAudienceEvent(this.response);

  @override
  List<Object?> get props => [response];
}

class UserChangedToBroadcasterEvent extends SocketsEvent {
  final dynamic response;
  const UserChangedToBroadcasterEvent(this.response);

  @override
  List<Object?> get props => [response];
}

class UserAskedToBeBroadcasterEvent extends SocketsEvent {
  final dynamic response;
  const UserAskedToBeBroadcasterEvent(this.response);

  @override
  List<Object?> get props => [response];
}