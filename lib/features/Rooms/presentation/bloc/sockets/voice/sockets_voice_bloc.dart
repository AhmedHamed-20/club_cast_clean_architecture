import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/constants/check_mic_permission.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/core/routes/app_route_names.dart';
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
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../../../core/agora/agora_helper.dart';
import '../../../../../../core/constants/default_values.dart';
import '../../../../../../core/network/endpoints.dart';
import '../../../../domain/entities/active_room_user_data_enitie.dart';
import '../../../../domain/entities/admin_entitie.dart';
import '../../../../domain/entities/audience_entite.dart';
import '../../../../domain/entities/brodcasters_entitie.dart';
import '../../../../domain/entities/me_entitie.dart';
import '../../../screens/room_screen.dart';
import '../chat/chat_bloc.dart';

part 'sockets_event_voice.dart';
part 'sockets_voice_state.dart';

class SocketsVoiceBloc extends Bloc<SocketsEvent, SocketsVoiceState> {
  SocketsVoiceBloc(this.layoutBloc, this.roomChatBloc, this.assetsAudioPlayer)
      : super(const SocketsVoiceState()) {
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
    on<RemoteUserMuteStateEvent>(_remoteUserMuteState);
    on<ActiveUserTalkingEvent>(_activeUserTalking);
    on<MuteUnMuteLocalAudioEvent>(_muteLocalAudio);
    on<SocketsErrorsEvent>(_socketErrorEvent);
    on<PlayRoomSoundEvent>(_playRoomSound);
    on<MuteSomeOneEvent>(_muteSomeOne);
  }
  final LayoutBloc layoutBloc;
  final ChatBloc roomChatBloc;
  AssetsAudioPlayer assetsAudioPlayer;
  late RtcEngineEventHandler rtcEngineEventHandler;
  final AgoraHelper agoraHelper = AgoraHelper();
  FutureOr<void> _connectToSocket(
      ConnectToSocketEvent event, Emitter<SocketsVoiceState> emit) async {
    if (ConstVar.layoutBottomSheetStatus !=
            LayoutBottomSheetStatus.playingPodcast &&
        await CheckMicPermission.checkMicPermission() == true) {
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
            .enableForceNew()
            .disableAutoConnect()
            .build(),
      );

      ConstVar.socket.connect();
      ConstVar.socket.onConnectError((data) {
        add(SocketsErrorsEvent(data));
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
        add(SocketsErrorsEvent(error));
      });
    } else {
      if (ConstVar.layoutBottomSheetStatus !=
          LayoutBottomSheetStatus.playingPodcast) {
        flutterToast(
          msg: 'you can\'t join or create room while playing podcast',
          backgroundColor: AppColors.toastWarning,
          textColor: AppColors.black,
        );
      }
    }
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
      JoinRoomSuccessEvent event, Emitter<SocketsVoiceState> emit) async {
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
    layoutBloc.add(
      const BottomSheetStatusEvent(
        layoutBottomSheetStatus: LayoutBottomSheetStatus.playingLiveVoiceRoom,
      ),
    );
    await agoraHelper.initAgoraThenJoinRoom(
      appID: event.response[1]['APP_ID'],
      clientRoleType: ClientRoleType.clientRoleAudience,
      roomName: event.response[1]['name'],
      token: event.response[2],
      uid: event.response[0]['uid'],
    );
    listenOnAgoraEvents();
    listenOnSocketEvents();
    add(const PlayRoomSoundEvent(AssetsPath.userEnterAudio));
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
        socket: ConstVar.socket,
        handler: (response) {
          agoraHelper.changeRole(
              clientRoleType: ClientRoleType.clientRoleAudience,
              token: response);
        });
    SocketHelper.listenOnBroadCasterToken(
      socket: ConstVar.socket,
      handler: (response) {
        agoraHelper.changeRole(
            clientRoleType: ClientRoleType.clientRoleBroadcaster,
            token: response);
      },
    );
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
    add(const PlayRoomSoundEvent(AssetsPath.userLeftAudio));
  }

  FutureOr<void> _userJoined(
      UserJoinedEvent event, Emitter<SocketsVoiceState> emit) {
    AudienceEntitie? audienceEntitie = state.audienceEntitie.copyWith();

    audienceEntitie.audience.add(ActiveRoomUserModel.fromJson(event.response));
    emit(state.copyWith(audienceEntitie: audienceEntitie));
    add(const PlayRoomSoundEvent(AssetsPath.userEnterAudio));
  }

  FutureOr<void> _adminLeft(
      AdminLeftEvent event, Emitter<SocketsVoiceState> emit) {
    flutterToast(
        msg:
            'Admin left the room if he not back in 1 minute the room will be closed',
        backgroundColor: AppColors.toastWarning,
        textColor: AppColors.black);
    add(const PlayRoomSoundEvent(AssetsPath.adminLeftAudio));
  }

  FutureOr<void> _roomEnded(
      RoomEndedEvent event, Emitter<SocketsVoiceState> emit) {
    Navigator.pushNamedAndRemoveUntil(roomsWidgetKey.currentState!.context,
        AppRoutesNames.layoutScreen, (route) => false);
    flutterToast(
        msg: 'room ended',
        backgroundColor: AppColors.toastWarning,
        textColor: AppColors.black);
    add(const LeaveRoomEvent());
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
    add(const PlayRoomSoundEvent(AssetsPath.userBecomeAudienceAudio));
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
    add(const PlayRoomSoundEvent(AssetsPath.userBecomeSpeakerAudio));
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
      RoomCreatedSuccessEvent event, Emitter<SocketsVoiceState> emit) async {
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

    layoutBloc.add(const BottomSheetStatusEvent(
        layoutBottomSheetStatus: LayoutBottomSheetStatus.playingLiveVoiceRoom));
    await agoraHelper.initAgoraThenJoinRoom(
      appID: event.response[1]['APP_ID'],
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      roomName: event.response[1]['name'],
      token: event.response[2],
      uid: event.response[0]['uid'],
    );
    if (event.response[1]['isRecording']) {
      await agoraHelper.recording(roomName: event.response[1]['name']);
    }
    listenOnAgoraEvents();
    listenOnSocketEvents();
    add(const PlayRoomSoundEvent(AssetsPath.userEnterAudio));
  }

  FutureOr<void> _leaveRoom(
      LeaveRoomEvent event, Emitter<SocketsVoiceState> emit) async {
    if (state.isCreateRoom == true) {
      SocketHelper.endRoomAdmin(socket: ConstVar.socket);
      if (state.joinCreateRoomEntitie.isRecording) {
        await agoraHelper.stopRecording();
      }
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
      ConstVar.socket.io.options.clear();
      ConstVar.socket.io.destroy(ConstVar.socket);
      ConstVar.socket.dispose();
      ConstVar.socket.destroy();
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
      ConstVar.socket.io.options.clear();
      ConstVar.socket.io.destroy(ConstVar.socket);

      ConstVar.socket.dispose();
      ConstVar.socket.destroy();
    }
    layoutBloc.add(const BottomSheetStatusEvent(
        layoutBottomSheetStatus: LayoutBottomSheetStatus.idle));
    await agoraHelper.leaveRoom(rtcEngineEventHandler);
    await assetsAudioPlayer.dispose();
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

  void listenOnAgoraEvents() {
    rtcEngineEventHandler = RtcEngineEventHandler(
      onAudioVolumeIndication:
          (connection, speakers, speakerNumber, totalVolume) {
        add(ActiveUserTalkingEvent(audioInfo: speakers));
      },
      onUserMuteAudio: (connection, remoteUid, muted) {
        add(RemoteUserMuteStateEvent(uid: remoteUid, isMuted: muted));
      },
    );
    agoraHelper.listenOnAgoraEvents(
        rtcEngineEventHandler: rtcEngineEventHandler);
  }

  FutureOr<void> _remoteUserMuteState(
      RemoteUserMuteStateEvent event, Emitter<SocketsVoiceState> emit) {
    if (event.uid == state.adminEntitie.admin.uid) {
      AdminEntitie admin = AdminEntitie(state.adminEntitie.admin
          .copyWith(isMutted: event.isMuted, isSpeaking: false));
      emit(state.copyWith(adminEntitie: admin));
    } else {
      List<ActiveRoomUserDataEntitie> broadCasters =
          state.brodcastersEnitite.brodcasters;
      for (int i = 0; i < broadCasters.length; i++) {
        if (state.brodcastersEnitite.brodcasters[i].uid == event.uid) {
          broadCasters[i] = broadCasters[i].copyWith(
            isMutted: event.isMuted,
            isSpeaking: false,
          );
          break;
        }
      }
      emit(
          state.copyWith(brodcastersEnitite: BrodcastersEntitie(broadCasters)));
    }
  }

  FutureOr<void> _activeUserTalking(
      ActiveUserTalkingEvent event, Emitter<SocketsVoiceState> emit) {
    List<ActiveRoomUserDataEntitie> broadCasters =
        state.brodcastersEnitite.brodcasters;
    ActiveRoomUserDataEntitie admin = state.adminEntitie.admin;
    ActiveRoomUserDataEntitie me = state.meEntitie.me;
    bool isAdminChanged = false;
    bool isMeChanged = false;
    for (int j = 0; j < event.audioInfo.length; j++) {
      if (state.adminEntitie.admin.uid == event.audioInfo[j].uid) {
        admin = state.adminEntitie.admin
            .copyWith(isSpeaking: event.audioInfo[j].volume! > 3);
        isAdminChanged = event.audioInfo[j].volume! > 3;
      } else {
        admin = state.adminEntitie.admin.copyWith(isSpeaking: false);
      }
      if (state.isCreateRoom &&
          event.audioInfo[j].uid == 0 &&
          state.meEntitie.me.isMutted == false) {
        me = state.meEntitie.me
            .copyWith(isSpeaking: event.audioInfo[j].volume! > 3);
        isMeChanged = event.audioInfo[j].volume! > 3;
      } else {
        me = state.meEntitie.me.copyWith(isSpeaking: false);
      }
      if (state.brodcastersEnitite.brodcasters.isNotEmpty) {
        for (int i = 0; i < broadCasters.length; i++) {
          if (state.brodcastersEnitite.brodcasters[i].uid ==
              event.audioInfo[j].uid) {
            broadCasters[i] = broadCasters[i].copyWith(
              isSpeaking: event.audioInfo[j].volume! > 3,
            );
          }
          if (state.brodcastersEnitite.brodcasters[i].uid ==
                  state.meEntitie.me.uid &&
              event.audioInfo[j].uid == 0 &&
              state.brodcastersEnitite.brodcasters[i].isMutted == false) {
            broadCasters[i] = broadCasters[i].copyWith(
              isSpeaking: event.audioInfo[j].volume! > 3,
            );
          }
        }
      }
    }
    if (isAdminChanged ||
        isMeChanged ||
        state.adminEntitie.admin.isSpeaking ||
        state.meEntitie.me.isSpeaking ||
        state.brodcastersEnitite.brodcasters.isNotEmpty) {
      emit(
        state.copyWith(
          brodcastersEnitite: BrodcastersEntitie(List.from(broadCasters)),
          adminEntitie: AdminEntitie(admin),
          meEntitie: MeEntitie(me),
        ),
      );
    }
  }

  FutureOr<void> _muteLocalAudio(
      MuteUnMuteLocalAudioEvent event, Emitter<SocketsVoiceState> emit) async {
    await agoraHelper.muteMyVoice(mute: event.isMuted);
    if (state.isCreateRoom) {
      emit(
        state.copyWith(
          meEntitie: MeEntitie(state.meEntitie.me
              .copyWith(isMutted: event.isMuted, isSpeaking: false)),
          liveVoiceRoomFloatingButtonStatus: event.isMuted
              ? LiveVoiceRoomFloatingButtonStatus.unmute
              : LiveVoiceRoomFloatingButtonStatus.mute,
        ),
      );
    } else {
      emit(
        state.copyWith(
          brodcastersEnitite: state.brodcastersEnitite.copyWith(
            brodcasters: state.brodcastersEnitite.brodcasters
                .map((e) => e.uid == state.meEntitie.me.uid
                    ? e.copyWith(isMutted: event.isMuted, isSpeaking: false)
                    : e)
                .toList(),
          ),
          liveVoiceRoomFloatingButtonStatus: event.isMuted
              ? LiveVoiceRoomFloatingButtonStatus.unmute
              : LiveVoiceRoomFloatingButtonStatus.mute,
        ),
      );
    }
  }

  FutureOr<void> _socketErrorEvent(
      SocketsErrorsEvent event, Emitter<SocketsVoiceState> emit) {
    flutterToast(
        msg: event.error.toString(),
        backgroundColor: AppColors.toastError,
        textColor: AppColors.white);
    if (event.error.toString() == 'transport closed') {
      add(const LeaveRoomEvent());
      roomChatBloc.add(const LeaveChatRoomEvent());
    }
    if (state.isCreateRoom) {
      emit(state.copyWith(
          createRoomRequestStatus: CreateRoomRequestStatus.error));
    } else {
      emit(state.copyWith(joinRoomRequestStatus: JoinRoomRequestStatus.error));
    }
  }

  FutureOr<void> _playRoomSound(
      PlayRoomSoundEvent event, Emitter<SocketsVoiceState> emit) async {
    assetsAudioPlayer = AssetsAudioPlayer();
    await assetsAudioPlayer.open(
      Audio(
        event.soundPath,
      ),
    );
  }

  FutureOr<void> _muteSomeOne(
      MuteSomeOneEvent event, Emitter<SocketsVoiceState> emit) async {
    await agoraHelper.muteSomeone(uid: event.uid, mute: event.isMuted);
    if (event.uid == state.adminEntitie.admin.uid) {
      emit(state.copyWith(
          adminEntitie: AdminEntitie(state.adminEntitie.admin
              .copyWith(iMuteHim: event.isMuted, isSpeaking: false))));
    } else {
      BrodcastersEntitie brodcastersEntitie = state.brodcastersEnitite;
      for (int i = 0; i < state.brodcastersEnitite.brodcasters.length; i++) {
        if (state.brodcastersEnitite.brodcasters[i].uid == event.uid) {
          brodcastersEntitie.brodcasters[i] = brodcastersEntitie.brodcasters[i]
              .copyWith(iMuteHim: event.isMuted, isSpeaking: false);
          break;
        }
      }
      emit(state.copyWith(brodcastersEnitite: brodcastersEntitie.copyWith()));
    }
  }
}
