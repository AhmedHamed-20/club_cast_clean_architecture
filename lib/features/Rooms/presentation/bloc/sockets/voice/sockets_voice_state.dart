// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sockets_voice_bloc.dart';

class SocketsState extends Equatable {
  final String errorMessage;
  final ConnectToSocketRequestStatus connectToSocketRequestStatus;
  final JoinRoomRequestStatus joinRoomRequestStatus;
  final CreateRoomRequestStatus createRoomRequestStatus;
  final JoinCreateRoomEntitie? joinCreateRoomEntitie;
  final AudienceEntitie? audienceEntitie;
  final AdminEntitie? adminEntitie;
  final BrodcastersEnitite? brodcastersEnitite;
  final MeEntitie? meEntitie;
  final bool isCreateRoom;
  final LiveVoiceRoomFloatingButtonStatus liveVoiceRoomFloatingButtonStatus;
  const SocketsState({
    this.errorMessage = '',
    this.isCreateRoom = false,
    this.createRoomRequestStatus = CreateRoomRequestStatus.idle,
    this.joinRoomRequestStatus = JoinRoomRequestStatus.idle,
    this.connectToSocketRequestStatus = ConnectToSocketRequestStatus.idle,
    this.adminEntitie,
    this.audienceEntitie,
    this.brodcastersEnitite,
    this.meEntitie,
    this.liveVoiceRoomFloatingButtonStatus =
        LiveVoiceRoomFloatingButtonStatus.askToTalk,
    this.joinCreateRoomEntitie,
  });

  SocketsState copyWith({
    LiveVoiceRoomFloatingButtonStatus? liveVoiceRoomFloatingButtonStatus,
    CreateRoomRequestStatus? createRoomRequestStatus,
    MeEntitie? meEntitie,
    bool? isCreateRoom,
    AudienceEntitie? audienceEntitie,
    BrodcastersEnitite? brodcastersEnitite,
    AdminEntitie? adminEntitie,
    JoinCreateRoomEntitie? joinCreateRoomEntitie,
    JoinRoomRequestStatus? joinRoomRequestStatus,
    String? errorMessage,
    ConnectToSocketRequestStatus? connectToSocketRequestStatus,
  }) {
    return SocketsState(
      liveVoiceRoomFloatingButtonStatus: liveVoiceRoomFloatingButtonStatus ??
          this.liveVoiceRoomFloatingButtonStatus,
      isCreateRoom: isCreateRoom ?? this.isCreateRoom,
      createRoomRequestStatus:
          createRoomRequestStatus ?? this.createRoomRequestStatus,
      meEntitie: meEntitie ?? this.meEntitie,
      adminEntitie: adminEntitie ?? this.adminEntitie,
      audienceEntitie: audienceEntitie ?? this.audienceEntitie,
      brodcastersEnitite: brodcastersEnitite ?? this.brodcastersEnitite,
      joinCreateRoomEntitie:
          joinCreateRoomEntitie ?? this.joinCreateRoomEntitie,
      joinRoomRequestStatus:
          joinRoomRequestStatus ?? this.joinRoomRequestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      connectToSocketRequestStatus:
          connectToSocketRequestStatus ?? this.connectToSocketRequestStatus,
    );
  }

  @override
  List<Object?> get props => [
        liveVoiceRoomFloatingButtonStatus,
        createRoomRequestStatus,
        errorMessage,
        connectToSocketRequestStatus,
        joinRoomRequestStatus,
        adminEntitie,
        isCreateRoom,
        joinCreateRoomEntitie,
        audienceEntitie,
        brodcastersEnitite,
        meEntitie,
        identityHashCode(this),
      ];
}
