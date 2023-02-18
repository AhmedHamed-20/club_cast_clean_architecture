part of 'sockets_voice_bloc.dart';

abstract class SocketsEvent extends Equatable {
  const SocketsEvent();
}

class ConnectToSocketEvent extends SocketsEvent {
  final String accessToken;
  final bool isCreateRoom;
  final CreateRoomParams? createRoomParams;
  final String? roomName;
  const ConnectToSocketEvent(
      {required this.accessToken,
      required this.isCreateRoom,
      this.createRoomParams,
      this.roomName});

  @override
  List<Object> get props => [accessToken];
}

class JoinRoomEvent extends SocketsEvent {
  final String roomName;

  const JoinRoomEvent({required this.roomName});

  @override
  List<Object> get props => [roomName];
}

class ConnectToSocketsSuccessEvent extends SocketsEvent {
  final bool isCreateRoom;
  final CreateRoomParams? createRoomParams;
  final String? roomName;
  const ConnectToSocketsSuccessEvent(
      {required this.isCreateRoom, this.createRoomParams, this.roomName});

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

class CreateRoomEvent extends SocketsEvent {
  final String roomName;
  final String category;
  final bool isRecording;
  final String status;
  const CreateRoomEvent(
      {required this.roomName,
      required this.category,
      required this.isRecording,
      required this.status});

  @override
  List<Object?> get props => [roomName, category, isRecording, status];
}

class RoomCreatedSuccessEvent extends SocketsEvent {
  final dynamic response;
  const RoomCreatedSuccessEvent(this.response);

  @override
  List<Object?> get props => [response];
}

class LeaveRoomEvent extends SocketsEvent {
  const LeaveRoomEvent();

  @override
  List<Object?> get props => [];
}

class AskToTalkEvent extends SocketsEvent {
  const AskToTalkEvent();

  @override
  List<Object?> get props => [];
}

class GivePermsToUserToTalkEvent extends SocketsEvent {
  final ActiveRoomUserModel activeRoomUserModel;
  const GivePermsToUserToTalkEvent({required this.activeRoomUserModel});

  @override
  List<Object?> get props => [activeRoomUserModel];
}

class ReturnUserToAudience extends SocketsEvent {
  final ActiveRoomUserModel activeRoomUserModel;
  const ReturnUserToAudience({required this.activeRoomUserModel});

  @override
  List<Object?> get props => [activeRoomUserModel];
}

class ReturnToAudience extends SocketsEvent {
  const ReturnToAudience();

  @override
  List<Object?> get props => [];
}

class RemoteUserMuteStateEvent extends SocketsEvent {
  final int uid;
  final bool isMuted;
  const RemoteUserMuteStateEvent({required this.uid, required this.isMuted});

  @override
  List<Object?> get props => [uid, isMuted];
}
