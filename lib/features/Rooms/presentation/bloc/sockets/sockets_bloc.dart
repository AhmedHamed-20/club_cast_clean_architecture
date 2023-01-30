import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/core/socket/socket_helper.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/models/active_room_user_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/models/admin_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/models/audience_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/models/brodcasters_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/models/join_create_room_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/models/me_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/join_create_room_entitie.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../../domain/entities/admin_entitie.dart';
import '../../../domain/entities/audience_entite.dart';
import '../../../domain/entities/brodcasters_entitie.dart';
import '../../../domain/entities/me_entitie.dart';
part 'sockets_event.dart';
part 'sockets_state.dart';

class SocketsBloc extends Bloc<SocketsEvent, SocketsState> {
  SocketsBloc() : super(const SocketsState()) {
    on<ConnectToSocketEvent>(_connectToSocket);
    on<JoinRoomEvent>(_joinRoom);
    on<ConnectToSocketsSuccessEvent>(_connectToSocketSuccess);
    on<JoinRoomSuccessEvent>(_joinRoomSuccess);
    on<UserLeftEvent>(_userLeft);
    on<UserJoinedEvent>(_userJoined);
    on<AdminLeftEvent>(_adminLeft);
    on<RoomEndedEvent>(_roomEnded);
    on<UserAskedToBeBroadcasterEvent>(_userAskedToBeBroadcaster);
    on<UserChangedToAudienceEvent>(_userChangedToAudience);
    on<UserChangedToBroadcasterEvent>(_userChangedToBroadcaster);
    on<CreateRoomEvent>(_createRoom);
    on<RoomCreatedSuccessEvent>(_roomCreatedSuccess);
    on<LeaveRoomEvent>(_leaveRoom);
  }

  late Socket socket;

  FutureOr<void> _connectToSocket(
      ConnectToSocketEvent event, Emitter<SocketsState> emit) async {
    emit(state.copyWith(
        connectToSocketRequestStatus: ConnectToSocketRequestStatus.loading));

    socket = io(
      'https://audiocomms-podcast-api.onrender.com/',
      <String, dynamic>{
        'auth': {'token': event.accessToken},
        'transports': ['websocket'],
      },
    );

    socket.connect();
    socket.on('connect', (_) {
      add(const ConnectToSocketsSuccessEvent());
    });
    socket.on('error', (error) {});
  }

  FutureOr<void> _joinRoom(JoinRoomEvent event, Emitter<SocketsState> emit) {
    emit(state.copyWith(joinRoomRequestStatus: JoinRoomRequestStatus.loading));
    SocketHelper.joinRoom(socket: socket, roomName: event.roomName);
    SocketHelper.listenOnRoomJoined(
        socket: socket,
        handler: (response) {
          add(JoinRoomSuccessEvent(response));
        });
  }

  FutureOr<void> _connectToSocketSuccess(
      ConnectToSocketsSuccessEvent event, Emitter<SocketsState> emit) {
    emit(state.copyWith(
        connectToSocketRequestStatus: ConnectToSocketRequestStatus.success));
  }

  FutureOr<void> _joinRoomSuccess(
      JoinRoomSuccessEvent event, Emitter<SocketsState> emit) {
    emit(
      state.copyWith(
        isCreateRoom: false,
        adminEntitie: AdminModel.fromJson(event.response),
        audienceEntitie: AudiencesModel.fromJson(event.response),
        brodcastersEnitite: BrodCasterssModel.fromJson(event.response),
        meEntitie: MeModel.fromJson(event.response),
        joinCreateRoomEntitie: JoinCreateRooModel.fromJson(event.response),
        joinRoomRequestStatus: JoinRoomRequestStatus.success,
      ),
    );
    listenOnSocketEvents();
  }

  void listenOnSocketEvents() {
    SocketHelper.lisentOnUserAskedToTalk(
        socket: socket,
        handler: (response) {
          add(UserAskedToBeBroadcasterEvent(response));
        });
    SocketHelper.listenOnAdminLeft(
        socket: socket,
        handler: (resposne) {
          add(AdminLeftEvent(resposne));
        });

    SocketHelper.listenOnRoomEnded(
        socket: socket,
        handler: (response) {
          add(RoomEndedEvent(response));
        });

    SocketHelper.listenOnUserChangedToAudience(
        socket: socket,
        handler: (response) {
          add(UserChangedToAudienceEvent(response));
        });
    SocketHelper.listenOnUserChangedToBrodcaster(
        socket: socket,
        handler: (response) {
          add(UserChangedToBroadcasterEvent(response));
        });

    SocketHelper.listenOnUserJoin(
        socket: socket,
        handler: (response) {
          add(UserJoinedEvent(response));
        });

    SocketHelper.listenOnUserLeft(
        socket: socket,
        handler: (response) {
          add(UserLeftEvent(response));
        });
    SocketHelper.lisenOnErrors(socket: socket, handler: (response) {});
  }

  FutureOr<void> _userLeft(UserLeftEvent event, Emitter<SocketsState> emit) {
    AudienceEntitie? audienceEntitie = state.audienceEntitie;
    bool isFound = false;
    for (int i = 0; i < state.audienceEntitie!.audience.length; i++) {
      if (state.audienceEntitie!.audience[i].id == event.response['_id']) {
        audienceEntitie!.audience.removeAt(i);
        isFound = true;
        emit(state.copyWith(audienceEntitie: audienceEntitie));
        break;
      }
    }
    if (isFound == false) {
      BrodcastersEnitite? brodcastersEnitite = state.brodcastersEnitite;
      for (int i = 0; i < state.brodcastersEnitite!.brodcasters.length; i++) {
        if (state.brodcastersEnitite!.brodcasters[i].id ==
            event.response['_id']) {
          brodcastersEnitite!.brodcasters.removeAt(i);
          isFound = true;
          emit(state.copyWith(brodcastersEnitite: brodcastersEnitite));
          break;
        }
      }
    }
  }

  FutureOr<void> _userJoined(
      UserJoinedEvent event, Emitter<SocketsState> emit) {
    AudienceEntitie? audienceEntitie = state.copyWith().audienceEntitie;
    if (audienceEntitie != null) {
      audienceEntitie.audience
          .add(ActiveRoomUserModel.fromJson(event.response));
    }
    emit(state.copyWith(audienceEntitie: audienceEntitie));
  }

  FutureOr<void> _adminLeft(AdminLeftEvent event, Emitter<SocketsState> emit) {
    flutterToast(
        msg:
            'Admin left the room if he not back in 1 minute the room will be closed',
        backgroundColor: AppColors.toastWarning,
        textColor: AppColors.black);
  }

  FutureOr<void> _roomEnded(RoomEndedEvent event, Emitter<SocketsState> emit) {
    socket.disconnect();
    emit(state.copyWith(joinRoomRequestStatus: JoinRoomRequestStatus.left));
  }

  FutureOr<void> _userAskedToBeBroadcaster(
      UserAskedToBeBroadcasterEvent event, Emitter<SocketsState> emit) {
    AudienceEntitie? audienceEntitie = state.audienceEntitie;
    if (state.audienceEntitie != null) {
      for (int i = 0; i < state.audienceEntitie!.audience.length; i++) {
        if (state.audienceEntitie!.audience[i].id == event.response['id']) {
          audienceEntitie!.audience[i] = audienceEntitie.audience[i].copyWith(
            askedToSpeak: true,
          );
          break;
        }
      }
    }
    emit(state.copyWith(audienceEntitie: audienceEntitie));
  }

  FutureOr<void> _userChangedToAudience(
      UserChangedToAudienceEvent event, Emitter<SocketsState> emit) {
    BrodcastersEnitite? brodcastersEnitite = state.brodcastersEnitite;
    AudienceEntitie? audienceEntitie = state.audienceEntitie;
    for (int i = 0; i < state.brodcastersEnitite!.brodcasters.length; i++) {
      if (state.brodcastersEnitite!.brodcasters[i].id ==
          event.response['_id']) {
        brodcastersEnitite!.brodcasters.removeAt(i);
        break;
      }
    }
    if (audienceEntitie != null) {
      audienceEntitie.audience
          .add(ActiveRoomUserModel.fromJson(event.response));
    }
    emit(state.copyWith(
        brodcastersEnitite: brodcastersEnitite,
        audienceEntitie: audienceEntitie));
  }

  FutureOr<void> _userChangedToBroadcaster(
      UserChangedToBroadcasterEvent event, Emitter<SocketsState> emit) {
    BrodcastersEnitite? brodcastersEnitite = state.brodcastersEnitite;
    AudienceEntitie? audienceEntitie = state.audienceEntitie;
    for (int i = 0; i < state.audienceEntitie!.audience.length; i++) {
      if (state.audienceEntitie!.audience[i].id == event.response['_id']) {
        audienceEntitie!.audience.removeAt(i);
        break;
      }
    }
    if (brodcastersEnitite != null) {
      brodcastersEnitite.brodcasters
          .add(ActiveRoomUserModel.fromJson(event.response));
    }
    emit(state.copyWith(
        brodcastersEnitite: brodcastersEnitite,
        audienceEntitie: audienceEntitie));
  }

  FutureOr<void> _createRoom(
      CreateRoomEvent event, Emitter<SocketsState> emit) {
    emit(state.copyWith(
        createRoomRequestStatus: CreateRoomRequestStatus.loading));
    SocketHelper.createRoom(
      socket: socket,
      createRoomParams: CreateRoomParams(
        roomName: event.roomName,
        category: event.category,
        isRecording: event.isRecording,
        status: event.status,
      ),
    );
    SocketHelper.listenOnRoomCreated(
        socket: socket,
        handler: (response) {
          add(RoomCreatedSuccessEvent(response));
        });
  }

  FutureOr<void> _roomCreatedSuccess(
      RoomCreatedSuccessEvent event, Emitter<SocketsState> emit) {
    emit(
      state.copyWith(
        isCreateRoom: true,
        createRoomRequestStatus: CreateRoomRequestStatus.success,
        //  adminEntitie: AdminModel.fromJson(event.response),
        audienceEntitie: AudiencesModel.fromJson(event.response),
        brodcastersEnitite: BrodCasterssModel.fromJson(event.response),
        meEntitie: MeModel.fromJson(event.response),
        joinCreateRoomEntitie: JoinCreateRooModel.fromJson(event.response),
      ),
    );
    listenOnSocketEvents();
  }

  FutureOr<void> _leaveRoom(LeaveRoomEvent event, Emitter<SocketsState> emit) {
    if (state.isCreateRoom == true) {
      SocketHelper.adminEndRoom(socket: socket);
      emit(state.copyWith(
          createRoomRequestStatus: CreateRoomRequestStatus.left,
          isCreateRoom: false));
      socket.disconnect();
    } else {
      emit(state.copyWith(
          joinRoomRequestStatus: JoinRoomRequestStatus.left,
          isCreateRoom: false));
      socket.disconnect();
    }
  }
}
