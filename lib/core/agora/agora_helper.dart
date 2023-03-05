import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import '../constants/storage_permission_download_path.dart';

class AgoraHelper {
  late RtcEngine _engine;
  Future<void> initAgoraThenJoinRoom(
      {required String appID,
      required ClientRoleType clientRoleType,
      required String roomName,
      required int uid,
      required String token}) async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      RtcEngineContext(
        appId: appID,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ),
    );
    await _engine.disableVideo();
    await _engine.enableAudio();
    await _engine.setParameters('{"che.audio.opensl":true}');
    await _engine.enableAudioVolumeIndication(
      interval: 250,
      smooth: 3,
      reportVad: true,
    );
    await _engine.setClientRole(
      role: clientRoleType,
    );
    await _joinRoom(roomName: roomName, uid: uid, token: token);
  }

  Future<void> _joinRoom({
    required String roomName,
    required int uid,
    required String token,
  }) async {
    await _engine.joinChannel(
      token: token,
      channelId: roomName,
      uid: uid,
      options: const ChannelMediaOptions(
        enableAudioRecordingOrPlayout: true,
      ),
    );
  }

  listenOnAgoraEvents({required RtcEngineEventHandler rtcEngineEventHandler}) {
    _engine.registerEventHandler(
      rtcEngineEventHandler,
    );
  }

  Future<void> changeRole(
      {required ClientRoleType clientRoleType, required String token}) async {
    await _engine.renewToken(token);
    await _engine.setClientRole(
      role: clientRoleType,
    );
  }

  Future<void> muteMyVoice({required bool mute}) async {
    await _engine.muteLocalAudioStream(mute);
  }

  Future<void> leaveRoom(RtcEngineEventHandler rtcEngineEventHandler) async {
    _engine.unregisterEventHandler(rtcEngineEventHandler);

    await _engine.leaveChannel();
  }

  Future<void> recording({required String roomName}) async {
    File savedPath =
        await StoragePermissionAndPath.getRecordingFilePath(roomName);
    await _engine.startAudioRecording(
      AudioRecordingConfiguration(
        filePath: '${savedPath.path}.AAC',
        fileRecordingType: AudioFileRecordingType.audioFileRecordingMixed,
        encode: true,
        quality: AudioRecordingQualityType.audioRecordingQualityMedium,
      ),
    );
  }

  Future<void> stopRecording() async {
    await _engine.stopAudioRecording();
  }

  Future<void> muteSomeone({required int uid, required bool mute}) async {
    return await _engine.muteRemoteAudioStream(uid: uid, mute: mute);
  }
}
