// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sockets_voice_bloc.dart';

class SocketsVoiceState extends Equatable {
  final String errorMessage;
  final ConnectToSocketRequestStatus connectToSocketRequestStatus;
  final JoinRoomRequestStatus joinRoomRequestStatus;
  final CreateRoomRequestStatus createRoomRequestStatus;
  final JoinCreateRoomEntity joinCreateRoomEntitie;
  final AudienceEntity audienceEntitie;
  final AdminEntity adminEntitie;
  final BrodcastersEntity brodcastersEnitite;
  final MeEntity meEntitie;
  final bool isCreateRoom;
  final LiveVoiceRoomFloatingButtonStatus liveVoiceRoomFloatingButtonStatus;

  const SocketsVoiceState({
    this.errorMessage = '',
    this.isCreateRoom = false,
    this.createRoomRequestStatus = CreateRoomRequestStatus.idle,
    this.joinRoomRequestStatus = JoinRoomRequestStatus.idle,
    this.connectToSocketRequestStatus = ConnectToSocketRequestStatus.idle,
    this.adminEntitie = DefaultsValues.adminEntitieDefault,
    this.audienceEntitie = DefaultsValues.audienceEntitieDefault,
    this.brodcastersEnitite = DefaultsValues.broadCastersEntitieDefault,
    this.meEntitie = DefaultsValues.meEntitieDefault,
    this.liveVoiceRoomFloatingButtonStatus =
        LiveVoiceRoomFloatingButtonStatus.askToTalk,
    this.joinCreateRoomEntitie = DefaultsValues.joinCreateRoomEntitieDefault,
  });

  SocketsVoiceState copyWith({
    LiveVoiceRoomFloatingButtonStatus? liveVoiceRoomFloatingButtonStatus,
    CreateRoomRequestStatus? createRoomRequestStatus,
    MeEntity? meEntitie,
    bool? isCreateRoom,
    AudienceEntity? audienceEntitie,
    BrodcastersEntity? brodcastersEnitite,
    AdminEntity? adminEntitie,
    JoinCreateRoomEntity? joinCreateRoomEntitie,
    JoinRoomRequestStatus? joinRoomRequestStatus,
    String? errorMessage,
    ConnectToSocketRequestStatus? connectToSocketRequestStatus,
  }) {
    return SocketsVoiceState(
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
