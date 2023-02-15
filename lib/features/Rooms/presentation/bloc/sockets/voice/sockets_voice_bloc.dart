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

import '../../../../../../core/constants/default_values.dart';
import '../../../../../../core/network/endpoints.dart';
import '../../../../domain/entities/active_room_user_data_enitie.dart';
import '../../../../domain/entities/admin_entitie.dart';
import '../../../../domain/entities/audience_entite.dart';
import '../../../../domain/entities/brodcasters_entitie.dart';
import '../../../../domain/entities/me_entitie.dart';

part 'sockets_event_voice.dart';
part 'sockets_voice_state.dart';

class SocketsVoiceBloc extends Bloc<SocketsEvent, SocketsVoiceState> {
  SocketsVoiceBloc() : super(const SocketsVoiceState()) {
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
    on<AskToTalkEvent>(_askToTalk);
    on<GivePermsToUserToTalkEvent>(_givePermsToUserToTalk);
    on<ReturnUserToAudience>(_returnUserToAudience);
    on<ReturnToAudience>(_returnToAudience);
  }

  FutureOr<void> _connectToSocket(
      ConnectToSocketEvent event, Emitter<SocketsVoiceState> emit) async {
    emit(
      state.copyWith(
          connectToSocketRequestStatus: ConnectToSocketRequestStatus.loading,
          createRoomRequestStatus: CreateRoomRequestStatus.idle,
          joinRoomRequestStatus: JoinRoomRequestStatus.idle),
    );
    flutterToast(
        msg: 'Connecting to our server...',
        backgroundColor: AppColors.toastWarning,
        textColor: AppColors.black);
    ConstVar.socket = io(
      EndPoints.socketBaseUrl,
      OptionBuilder()
          .setAuth({'token': event.accessToken})
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    ConstVar.socket.connect();
    ConstVar.socket.onConnectError((data) {
      flutterToast(
          msg: data.toString(),
          backgroundColor: AppColors.toastError,
          textColor: AppColors.white);
      if (event.isCreateRoom) {
        emit(
          state.copyWith(
              connectToSocketRequestStatus: ConnectToSocketRequestStatus.error,
              createRoomRequestStatus: CreateRoomRequestStatus.error),
        );
      } else {
        emit(
          state.copyWith(
              connectToSocketRequestStatus: ConnectToSocketRequestStatus.error,
              joinRoomRequestStatus: JoinRoomRequestStatus.error),
        );
      }
    });
    ConstVar.socket.onDisconnect((data) {
      print(data);
    });
    //  ConstVar.socket.ondisconnect();
    ConstVar.socket.on('connect', (_) {
      if (event.isCreateRoom) {
        add(
          ConnectToSocketsSuccessEvent(
            isCreateRoom: event.isCreateRoom,
            createRoomParams: event.createRoomParams,
          ),
        );
      } else {
        add(
          ConnectToSocketsSuccessEvent(
            isCreateRoom: event.isCreateRoom,
            roomName: event.roomName,
          ),
        );
      }
    });
    ConstVar.socket.on('error', (error) {
      print(error);
    });
  }

  FutureOr<void> _joinRoom(
      JoinRoomEvent event, Emitter<SocketsVoiceState> emit) {
    emit(state.copyWith(joinRoomRequestStatus: JoinRoomRequestStatus.loading));
    SocketHelper.joinRoom(socket: ConstVar.socket, roomName: event.roomName);
    SocketHelper.listenOnRoomJoined(
        socket: ConstVar.socket,
        handler: (response) {
          add(JoinRoomSuccessEvent(response));
        });
  }

  FutureOr<void> _connectToSocketSuccess(
      ConnectToSocketsSuccessEvent event, Emitter<SocketsVoiceState> emit) {
    emit(
      state.copyWith(
        connectToSocketRequestStatus: ConnectToSocketRequestStatus.success,
      ),
    );
    if (event.isCreateRoom) {
      add(
        CreateRoomEvent(
          category: event.createRoomParams!.category,
          isRecording: event.createRoomParams!.isRecording,
          roomName: event.createRoomParams!.roomName,
          status: event.createRoomParams!.status,
        ),
      );
    } else {
      add(
        JoinRoomEvent(
          roomName: event.roomName!,
        ),
      );
    }
  }

  FutureOr<void> _joinRoomSuccess(
      JoinRoomSuccessEvent event, Emitter<SocketsVoiceState> emit) {
    emit(
      state.copyWith(
        isCreateRoom: false,
        liveVoiceRoomFloatingButtonStatus:
            LiveVoiceRoomFloatingButtonStatus.askToTalk,
        adminEntitie: AdminModel.fromJson(event.response),
        audienceEntitie: AudiencesModel.fromJson(
          event.response,
        ),
        brodcastersEnitite: BrodCasterssModel.fromJson(event.response),
        meEntitie: MeModel.fromJson(event.response),
        joinCreateRoomEntitie: JoinCreateRooModel.fromJson(event.response),
        joinRoomRequestStatus: JoinRoomRequestStatus.success,
      ),
    );
    listenOnSocketEvents();
  }

  void listenOnSocketEvents() {
    SocketHelper.lisenOnUserAskedToTalk(
        socket: ConstVar.socket,
        handler: (response) {
          add(UserAskedToBeBroadcasterEvent(response));
        });
    SocketHelper.listenOnAdminLeft(
        socket: ConstVar.socket,
        handler: (resposne) {
          add(AdminLeftEvent(resposne));
        });

    SocketHelper.listenOnRoomEnded(
        socket: ConstVar.socket,
        handler: (response) {
          add(RoomEndedEvent(response));
        });

    SocketHelper.listenOnUserChangedToAudience(
        socket: ConstVar.socket,
        handler: (response) {
          add(UserChangedToAudienceEvent(response));
        });
    SocketHelper.listenOnUserChangedToBrodcaster(
        socket: ConstVar.socket,
        handler: (response) {
          add(UserChangedToBroadcasterEvent(response));
        });

    SocketHelper.listenOnUserJoin(
        socket: ConstVar.socket,
        handler: (response) {
          add(UserJoinedEvent(response));
        });

    SocketHelper.listenOnUserLeft(
        socket: ConstVar.socket,
        handler: (response) {
          add(UserLeftEvent(response));
        });
    SocketHelper.listenOnErrors(
        socket: ConstVar.socket, handler: (response) {});
    SocketHelper.listenOnAudienceToken(
        socket: ConstVar.socket, handler: (response) {});
    SocketHelper.listenOnBroadCasterToken(
        socket: ConstVar.socket, handler: (response) {});
  }

  FutureOr<void> _userLeft(
      UserLeftEvent event, Emitter<SocketsVoiceState> emit) {
    AudienceEntitie? audienceEntitie = state.audienceEntitie.copyWith();
    bool isFound = false;
    for (int i = 0; i < state.audienceEntitie.audience.length; i++) {
      if (state.audienceEntitie.audience[i].id == event.response['_id']) {
        audienceEntitie.audience.removeAt(i);
        isFound = true;
        emit(state.copyWith(audienceEntitie: audienceEntitie));
        break;
      }
    }
    if (isFound == false) {
      BrodcastersEntitie? brodcastersEnitite =
          state.brodcastersEnitite.copyWith();
      for (int i = 0; i < state.brodcastersEnitite.brodcasters.length; i++) {
        if (state.brodcastersEnitite.brodcasters[i].id ==
            event.response['_id']) {
          brodcastersEnitite.brodcasters.removeAt(i);
          isFound = true;
          emit(state.copyWith(brodcastersEnitite: brodcastersEnitite));
          break;
        }
      }
    }
  }

  FutureOr<void> _userJoined(
      UserJoinedEvent event, Emitter<SocketsVoiceState> emit) {
    AudienceEntitie? audienceEntitie = state.audienceEntitie.copyWith();

    audienceEntitie.audience.add(ActiveRoomUserModel.fromJson(event.response));

    emit(state.copyWith(audienceEntitie: audienceEntitie));
  }

  FutureOr<void> _adminLeft(
      AdminLeftEvent event, Emitter<SocketsVoiceState> emit) {
    flutterToast(
        msg:
            'Admin left the room if he not back in 1 minute the room will be closed',
        backgroundColor: AppColors.toastWarning,
        textColor: AppColors.black);
  }

  FutureOr<void> _roomEnded(
      RoomEndedEvent event, Emitter<SocketsVoiceState> emit) {
    ConstVar.socket.disconnect();
    emit(state.copyWith(joinRoomRequestStatus: JoinRoomRequestStatus.left));
  }

  FutureOr<void> _userAskedToBeBroadcaster(
      UserAskedToBeBroadcasterEvent event, Emitter<SocketsVoiceState> emit) {
    List<ActiveRoomUserDataEntitie> audience = state.audienceEntitie.audience;
    for (int i = 0; i < audience.length; i++) {
      if (state.audienceEntitie.audience[i].id == event.response['_id']) {
        audience[i] = audience[i].copyWith(
          askedToSpeak: !audience[i].askedToSpeak,
        );
        break;
      }
    }

    emit(state.copyWith(audienceEntitie: AudienceEntitie(audience)));
  }

  FutureOr<void> _userChangedToAudience(
      UserChangedToAudienceEvent event, Emitter<SocketsVoiceState> emit) {
    BrodcastersEntitie? brodcastersEnitite = state.brodcastersEnitite;
    late List<ActiveRoomUserDataEntitie> audience;

    audience = state.audienceEntitie.audience;

    for (int i = 0; i < state.brodcastersEnitite.brodcasters.length; i++) {
      if (state.brodcastersEnitite.brodcasters[i].id == event.response['_id']) {
        brodcastersEnitite.brodcasters.removeAt(i);
        break;
      }
    }
    audience.add(ActiveRoomUserModel.fromJson(event.response));
    if (event.response['_id'] == state.meEntitie.me.id) {
      emit(state.copyWith(
          brodcastersEnitite: brodcastersEnitite,
          audienceEntitie: AudienceEntitie(audience),
          liveVoiceRoomFloatingButtonStatus:
              LiveVoiceRoomFloatingButtonStatus.askToTalk));
    } else {
      emit(state.copyWith(
          brodcastersEnitite: brodcastersEnitite,
          audienceEntitie: AudienceEntitie(audience)));
    }
  }

  FutureOr<void> _userChangedToBroadcaster(
      UserChangedToBroadcasterEvent event, Emitter<SocketsVoiceState> emit) {
    AudienceEntitie? audienceEntitie = state.audienceEntitie;
    late List<ActiveRoomUserDataEntitie> brodcasters;

    brodcasters = state.brodcastersEnitite.brodcasters;

    for (int i = 0; i < state.audienceEntitie.audience.length; i++) {
      if (state.audienceEntitie.audience[i].id == event.response['_id']) {
        audienceEntitie.audience.removeAt(i);
        break;
      }
    }
    brodcasters.add(ActiveRoomUserModel.fromJson(event.response));
    if (event.response['_id'] == state.meEntitie.me.id) {
      emit(
        state.copyWith(
            brodcastersEnitite: BrodcastersEntitie(brodcasters),
            audienceEntitie: audienceEntitie,
            liveVoiceRoomFloatingButtonStatus:
                LiveVoiceRoomFloatingButtonStatus.mute),
      );
    } else {
      emit(
        state.copyWith(
          brodcastersEnitite: BrodcastersEntitie(brodcasters),
          audienceEntitie: audienceEntitie,
        ),
      );
    }
  }

  FutureOr<void> _createRoom(
      CreateRoomEvent event, Emitter<SocketsVoiceState> emit) {
    emit(state.copyWith(
        createRoomRequestStatus: CreateRoomRequestStatus.loading));
    SocketHelper.createRoom(
      socket: ConstVar.socket,
      createRoomParams: CreateRoomParams(
        roomName: event.roomName,
        category: event.category,
        isRecording: event.isRecording,
        status: event.status,
      ),
    );
    SocketHelper.listenOnRoomCreated(
        socket: ConstVar.socket,
        handler: (response) {
          add(RoomCreatedSuccessEvent(response));
        });
  }

  FutureOr<void> _roomCreatedSuccess(
      RoomCreatedSuccessEvent event, Emitter<SocketsVoiceState> emit) {
    emit(
      state.copyWith(
        isCreateRoom: true,
        createRoomRequestStatus: CreateRoomRequestStatus.success,
        liveVoiceRoomFloatingButtonStatus:
            LiveVoiceRoomFloatingButtonStatus.mute,
        audienceEntitie: AudiencesModel.fromJson(
          event.response,
        ),
        brodcastersEnitite: BrodCasterssModel.fromJson(event.response),
        meEntitie: MeModel.fromJson(event.response),
        joinCreateRoomEntitie: JoinCreateRooModel.fromJson(event.response),
      ),
    );
    listenOnSocketEvents();
  }

  FutureOr<void> _leaveRoom(
      LeaveRoomEvent event, Emitter<SocketsVoiceState> emit) {
    if (state.isCreateRoom == true) {
      SocketHelper.endRoomAdmin(socket: ConstVar.socket);
      emit(
        state.copyWith(
          createRoomRequestStatus: CreateRoomRequestStatus.left,
          adminEntitie: DefaultsValues.adminEntitieDefault,
          audienceEntitie: DefaultsValues.audienceEntitieDefault,
          brodcastersEnitite: DefaultsValues.broadCastersEntitieDefault,
          meEntitie: DefaultsValues.meEntitieDefault,
          joinCreateRoomEntitie: DefaultsValues.joinCreateRoomEntitieDefault,
          isCreateRoom: false,
          connectToSocketRequestStatus: ConnectToSocketRequestStatus.idle,
        ),
      );
      ConstVar.socket.io.disconnect();
      ConstVar.socket.dispose();
    } else {
      emit(
        state.copyWith(
          joinRoomRequestStatus: JoinRoomRequestStatus.left,
          adminEntitie: DefaultsValues.adminEntitieDefault,
          audienceEntitie: DefaultsValues.audienceEntitieDefault,
          brodcastersEnitite: DefaultsValues.broadCastersEntitieDefault,
          meEntitie: DefaultsValues.meEntitieDefault,
          joinCreateRoomEntitie: DefaultsValues.joinCreateRoomEntitieDefault,
          isCreateRoom: false,
          connectToSocketRequestStatus: ConnectToSocketRequestStatus.idle,
        ),
      );
      ConstVar.socket.io.disconnect();
      ConstVar.socket.dispose();
    }
  }

  FutureOr<void> _askToTalk(
      AskToTalkEvent event, Emitter<SocketsVoiceState> emit) {
    SocketHelper.askToTalk(socket: ConstVar.socket);
    add(UserAskedToBeBroadcasterEvent({'_id': state.meEntitie.me.id}));
  }

  FutureOr<void> _givePermsToUserToTalk(
      GivePermsToUserToTalkEvent event, Emitter<SocketsVoiceState> emit) {
    SocketHelper.givePermsToUser(
        socket: ConstVar.socket, user: event.activeRoomUserModel.toJson());
  }

  FutureOr<void> _returnUserToAudience(
      ReturnUserToAudience event, Emitter<SocketsVoiceState> emit) {
    SocketHelper.returnUserToAudience(
        socket: ConstVar.socket, user: event.activeRoomUserModel.toJson());
  }

  FutureOr<void> _returnToAudience(
      ReturnToAudience event, Emitter<SocketsVoiceState> emit) {
    SocketHelper.returnToAudience(socket: ConstVar.socket);
  }
}
