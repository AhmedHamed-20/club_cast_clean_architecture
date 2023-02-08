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

import '../../../../../../core/network/endpoints.dart';
import '../../../../domain/entities/active_room_user_data_enitie.dart';
import '../../../../domain/entities/admin_entitie.dart';
import '../../../../domain/entities/audience_entite.dart';
import '../../../../domain/entities/brodcasters_entitie.dart';
import '../../../../domain/entities/me_entitie.dart';

part 'sockets_event_voice.dart';
part 'sockets_voice_state.dart';

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
    on<AskToTalkEvent>(_askToTalk);
  }

  FutureOr<void> _connectToSocket(
      ConnectToSocketEvent event, Emitter<SocketsState> emit) async {
    emit(
      state.copyWith(
          connectToSocketRequestStatus: ConnectToSocketRequestStatus.loading,
          createRoomRequestStatus: CreateRoomRequestStatus.idle,
          joinRoomRequestStatus: JoinRoomRequestStatus.idle),
    );
    ConstVar.socket = io(
      EndPoints.socketBaseUrl,
      OptionBuilder()
          .setAuth({'token': event.accessToken})
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    ConstVar.socket.connect();
    print(ConstVar.socket.io.options);
    ConstVar.socket.onDisconnect((data) {
      print(data);
    });
    //  ConstVar.socket.ondisconnect();
    ConstVar.socket.on('connect', (_) {
      add(const ConnectToSocketsSuccessEvent());
    });
    ConstVar.socket.on('error', (error) {
      print(error);
    });
  }

  FutureOr<void> _joinRoom(JoinRoomEvent event, Emitter<SocketsState> emit) {
    emit(state.copyWith(joinRoomRequestStatus: JoinRoomRequestStatus.loading));
    SocketHelper.joinRoom(socket: ConstVar.socket, roomName: event.roomName);
    SocketHelper.listenOnRoomJoined(
        socket: ConstVar.socket,
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
    print(event.response);
    emit(
      state.copyWith(
        isCreateRoom: false,
        liveVoiceRoomFloatingButtonStatus:
            LiveVoiceRoomFloatingButtonStatus.askToTalk,
        adminEntitie: AdminModel.fromJson(event.response),
        audienceEntitie: AudiencesModel.fromJson(event.response, false),
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
          print(resposne);
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
        socket: ConstVar.socket,
        handler: (response) {
          print(response);
        });
  }

  FutureOr<void> _userLeft(UserLeftEvent event, Emitter<SocketsState> emit) {
    AudienceEntitie? audienceEntitie = state.audienceEntitie?.copyWith();
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
      BrodcastersEnitite? brodcastersEnitite =
          state.brodcastersEnitite?.copyWith();
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
    AudienceEntitie? audienceEntitie = state.audienceEntitie?.copyWith();
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
    ConstVar.socket.disconnect();
    emit(state.copyWith(joinRoomRequestStatus: JoinRoomRequestStatus.left));
  }

  FutureOr<void> _userAskedToBeBroadcaster(
      UserAskedToBeBroadcasterEvent event, Emitter<SocketsState> emit) {
    List<ActiveRoomUserDataEntitie> audience = state.audienceEntitie!.audience;
    for (int i = 0; i < audience.length; i++) {
      if (state.audienceEntitie!.audience[i].id == event.response['_id']) {
        audience[i] = audience[i].copyWith(
          askedToSpeak: !audience[i].askedToSpeak,
        );
        break;
      }
    }

    emit(state.copyWith(audienceEntitie: AudienceEntitie(audience)));
  }

  FutureOr<void> _userChangedToAudience(
      UserChangedToAudienceEvent event, Emitter<SocketsState> emit) {
    BrodcastersEnitite? brodcastersEnitite = state.brodcastersEnitite;
    late List<ActiveRoomUserDataEntitie> audience;
    if (state.audienceEntitie == null) {
      audience = [];
    } else {
      audience = state.audienceEntitie!.audience;
    }
    for (int i = 0; i < state.brodcastersEnitite!.brodcasters.length; i++) {
      if (state.brodcastersEnitite!.brodcasters[i].id ==
          event.response['_id']) {
        brodcastersEnitite!.brodcasters.removeAt(i);
        break;
      }
    }
    audience.add(ActiveRoomUserModel.fromJson(event.response));
    emit(state.copyWith(
        brodcastersEnitite: brodcastersEnitite,
        audienceEntitie: AudienceEntitie(audience)));
  }

  FutureOr<void> _userChangedToBroadcaster(
      UserChangedToBroadcasterEvent event, Emitter<SocketsState> emit) {
    AudienceEntitie? audienceEntitie = state.audienceEntitie;
    late List<ActiveRoomUserDataEntitie> brodcasters;
    if (state.brodcastersEnitite == null) {
      brodcasters = [];
    } else {
      brodcasters = state.brodcastersEnitite!.brodcasters;
    }
    for (int i = 0; i < state.audienceEntitie!.audience.length; i++) {
      if (state.audienceEntitie!.audience[i].id == event.response['_id']) {
        audienceEntitie!.audience.removeAt(i);
        break;
      }
    }
    brodcasters.add(ActiveRoomUserModel.fromJson(event.response));
    emit(state.copyWith(
        brodcastersEnitite: BrodcastersEnitite(brodcasters),
        audienceEntitie: audienceEntitie));
  }

  FutureOr<void> _createRoom(
      CreateRoomEvent event, Emitter<SocketsState> emit) {
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
      RoomCreatedSuccessEvent event, Emitter<SocketsState> emit) {
    emit(
      state.copyWith(
        isCreateRoom: true,
        createRoomRequestStatus: CreateRoomRequestStatus.success,
        liveVoiceRoomFloatingButtonStatus:
            LiveVoiceRoomFloatingButtonStatus.mute,
        audienceEntitie: AudiencesModel.fromJson(event.response, true),
        brodcastersEnitite: BrodCasterssModel.fromJson(event.response),
        meEntitie: MeModel.fromJson(event.response),
        joinCreateRoomEntitie: JoinCreateRooModel.fromJson(event.response),
      ),
    );
    listenOnSocketEvents();
  }

  FutureOr<void> _leaveRoom(LeaveRoomEvent event, Emitter<SocketsState> emit) {
    if (state.isCreateRoom == true) {
      SocketHelper.endRoomAdmin(socket: ConstVar.socket);
      emit(
        state.copyWith(
          createRoomRequestStatus: CreateRoomRequestStatus.left,
          adminEntitie: null,
          audienceEntitie: null,
          brodcastersEnitite: null,
          meEntitie: null,
          joinCreateRoomEntitie: null,
          connectToSocketRequestStatus: ConnectToSocketRequestStatus.idle,
        ),
      );
      ConstVar.socket.io.disconnect();
      ConstVar.socket.dispose();
    } else {
      emit(
        state.copyWith(
          joinRoomRequestStatus: JoinRoomRequestStatus.left,
          adminEntitie: null,
          audienceEntitie: null,
          brodcastersEnitite: null,
          meEntitie: null,
          joinCreateRoomEntitie: null,
          connectToSocketRequestStatus: ConnectToSocketRequestStatus.idle,
        ),
      );
      ConstVar.socket.io.disconnect();
      ConstVar.socket.dispose();
    }
  }

  FutureOr<void> _askToTalk(AskToTalkEvent event, Emitter<SocketsState> emit) {
    SocketHelper.askToTalk(socket: ConstVar.socket);
    ActiveRoomUserDataEntitie activeRoomUserDataEntitie = state.meEntitie!.me
        .copyWith(askedToSpeak: !state.meEntitie!.me.askedToSpeak);
    emit(state.copyWith(
      meEntitie: MeEntitie(
        activeRoomUserDataEntitie,
      ),
    ));
  }
}
