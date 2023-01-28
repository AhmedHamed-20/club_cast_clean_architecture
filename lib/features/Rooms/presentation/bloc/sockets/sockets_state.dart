// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sockets_bloc.dart';

class SocketsState extends Equatable {
  final String errorMessage;
  final ConnectToSocketRequestStatus connectToSocketRequestStatus;
  final JoinRoomRequestStatus joinRoomRequestStatus;
  final JoinCreateRoomEntitie? joinCreateRoomEntitie;
  final AudienceEntitie? audienceEntitie;
  final AdminEntitie? adminEntitie;
  final BrodcastersEnitite? brodcastersEnitite;
  final MeEntitie? meEntitie;
  const SocketsState({
    this.errorMessage = '',
    this.joinRoomRequestStatus = JoinRoomRequestStatus.idle,
    this.connectToSocketRequestStatus = ConnectToSocketRequestStatus.idle,
    this.adminEntitie,
    this.audienceEntitie,
    this.brodcastersEnitite,
    this.meEntitie,
    this.joinCreateRoomEntitie,
  });

  SocketsState copyWith({
    MeEntitie? meEntitie,
    AudienceEntitie? audienceEntitie,
    BrodcastersEnitite? brodcastersEnitite,
    AdminEntitie? adminEntitie,
    JoinCreateRoomEntitie? joinCreateRoomEntitie,
    JoinRoomRequestStatus? joinRoomRequestStatus,
    String? errorMessage,
    ConnectToSocketRequestStatus? connectToSocketRequestStatus,
  }) {
    return SocketsState(
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
        errorMessage,
        connectToSocketRequestStatus,
        joinRoomRequestStatus,
        adminEntitie,
        joinCreateRoomEntitie,
        audienceEntitie,
        brodcastersEnitite,
        meEntitie,
      ];
}
