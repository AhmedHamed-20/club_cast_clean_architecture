import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/usecases/download_podcast.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/usecases/get_podcast_likes_users.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants/constants.dart';
import '../../../utl/utls.dart';
import '../../domain/entities/podcast_likes_users_entitie.dart';
import '../../domain/usecases/add_like.dart';
import '../../domain/usecases/remove_like.dart';

part 'common_playing_podcast_bloc_event.dart';
part 'common_playing_podcast_bloc_state.dart';

class CommonPlayingPodcastBlocBloc
    extends Bloc<CommonPlayingPodcastBlocEvent, CommonPlayingPodcastBlocState> {
  CommonPlayingPodcastBlocBloc(
      this.podcastLikesUsersUsecase,
      this.podcastDownloadUsecase,
      this.likeAddMyPodcastsUsecast,
      this.likeRemoveMyPodcastsUsecast)
      : super(const CommonPlayingPodcastBlocState()) {
    on<PodcastPlayEvent>(_playPodcast);
    on<PodcastPlayPaused>(_playPaused);
    on<PodcastPausePlaying>(_pausePlayingPodcast);
    on<PodcastStopPlaying>(_stopPlayingPodcast);
    on<CurrentPositionChangeValueEvent>(_changeCurrentPositionValue);
    on<PodcastBackGroundColorGenerateEvent>(_generateBackgroundColor);
    on<SeekToEvent>(_seekTo);
    on<SeekByEvent>(_seekByEvent);
    on<PodcastLikesUsersGetEvent>(_getPodcastLikesUser);
    on<PodcastDownloadEvent>(_downloadPodcast);
    on<LikeAddMyPodcastEvent>(_addLike);
    on<LikeRemoveMyPodcastEvent>(_removeLike);
    on<AddPodcastLikeIdToMapEvent>(_addPodcastLikeIdToMap);
  }
  late AssetsAudioPlayer myAssetAudioPlayer;
  final PodcastLikesUsersUsecase podcastLikesUsersUsecase;
  final PodcastDownloadUsecase podcastDownloadUsecase;
  final LikeAddMyPodcastsUsecast likeAddMyPodcastsUsecast;
  final LikeRemoveMyPodcastsUsecast likeRemoveMyPodcastsUsecast;
  FutureOr<void> _playPodcast(PodcastPlayEvent event,
      Emitter<CommonPlayingPodcastBlocState> emit) async {
    try {
      if (myAssetAudioPlayer.isPlaying.value) {
        add(PodcastStopPlaying(event.podcastId));
      }
    } catch (e) {
      myAssetAudioPlayer = AssetsAudioPlayer();
    }

    await myAssetAudioPlayer.open(
      Audio.network(
        event.podcastUrl,
        metas: Metas(
          title: event.podcastName,
          artist: event.podcastUserName,
          image: MetasImage(
            path: event.podcastPhoto,
            type: ImageType.network,
          ),
        ),
      ),
      showNotification: true,
      notificationSettings: NotificationSettings(
        nextEnabled: true,
        customNextIcon: AndroidResDrawable(name: 'ic_next_custom'),
        customPreviousIcon: AndroidResDrawable(name: 'ic_prev_custom'),
        customNextAction: (player) {
          add(const SeekByEvent(10));
        },
        customPrevAction: (player) {
          add(const SeekByEvent(-10));
        },
        customPlayPauseAction: (player) {
          if (player.isPlaying.value) {
            add(PodcastPausePlaying(event.podcastId));
          } else {
            add(PodcastPlayPaused(event.podcastId));
          }
        },
        customStopAction: (player) {
          add(PodcastStopPlaying(event.podcastId));
        },
        seekBarEnabled: true,
      ),
    );
    if (myAssetAudioPlayer.isPlaying.value) {
      currentPlayingPodcastsId = event.podcastId;
      currentPausePodcastsId = '';

      emit(state.copyWith(isPlaying: true));
    }
    myAssetAudioPlayer.currentPosition.listen(
      (event) {
        add(CurrentPositionChangeValueEvent(event.inSeconds));
      },
    );
  }

  FutureOr<void> _playPaused(PodcastPlayPaused event,
      Emitter<CommonPlayingPodcastBlocState> emit) async {
    await myAssetAudioPlayer.play();
    if (myAssetAudioPlayer.isPlaying.value) {
      currentPlayingPodcastsId = event.podcastId;
      currentPausePodcastsId = '';
      emit(state.copyWith(isPlaying: true));
    }
  }

  FutureOr<void> _pausePlayingPodcast(PodcastPausePlaying event,
      Emitter<CommonPlayingPodcastBlocState> emit) async {
    await myAssetAudioPlayer.pause();
    if (myAssetAudioPlayer.isPlaying.value == false) {
      currentPlayingPodcastsId = '';
      currentPausePodcastsId = event.podcastId;
      emit(state.copyWith(isPlaying: false));
    }
  }

  FutureOr<void> _stopPlayingPodcast(PodcastStopPlaying event,
      Emitter<CommonPlayingPodcastBlocState> emit) async {
    await myAssetAudioPlayer.stop();
    if (myAssetAudioPlayer.isPlaying.value == false) {
      currentPlayingPodcastsId = '';
      currentPausePodcastsId = '';
      emit(state.copyWith(isPlaying: false));
    }
  }

  FutureOr<void> _changeCurrentPositionValue(
      CurrentPositionChangeValueEvent event,
      Emitter<CommonPlayingPodcastBlocState> emit) {
    emit(state.copyWith(currentPosition: event.currentPosition));
  }

  FutureOr<void> _generateBackgroundColor(
      PodcastBackGroundColorGenerateEvent event,
      Emitter<CommonPlayingPodcastBlocState> emit) async {
    emit(state.copyWith(
        podcastInfoScreenColorsGenerateRequestStatus:
            BackGroundColorGenerateRequestStatus.loading,
        backGroundColors: const []));
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(event.image),
      maximumColorCount: 20,
    );
    if (paletteGenerator.colors.isNotEmpty) {
      paletteGenerator.paletteColors;
      emit(state.copyWith(
          podcastInfoScreenColorsGenerateRequestStatus:
              BackGroundColorGenerateRequestStatus.generated,
          backGroundColors: paletteGenerator.paletteColors));
    } else {
      emit(state.copyWith(
          podcastInfoScreenColorsGenerateRequestStatus:
              BackGroundColorGenerateRequestStatus.error,
          backGroundColors: const []));
    }
  }

  void onPressedOnPlay(
      {required String podcastId,
      required String podcastUrl,
      required String podcastName,
      required String podcastPhoto,
      required String podcastUserName}) {
    if (currentPlayingPodcastsId == podcastId) {
      add(PodcastPausePlaying(podcastId));
    } else if (currentPausePodcastsId == podcastId) {
      add(PodcastPlayPaused(podcastId));
    } else {
      add(
        PodcastPlayEvent(
          podcastUrl: podcastUrl,
          podcastId: podcastId,
          podcastName: podcastName,
          podcastPhoto: podcastPhoto,
          podcastUserName: podcastUserName,
        ),
      );
    }
  }

  double getCurrentPlayingPosition(
      {required int currentPosition,
      required String podcastId,
      required double podcastDuration}) {
    if (currentPosition != 0 &&
        (currentPlayingPodcastsId == podcastId ||
            currentPausePodcastsId == podcastId)) {
      return currentPosition.toDouble();
    } else {
      return podcastDuration;
    }
  }

  FutureOr<void> _seekTo(
      SeekToEvent event, Emitter<CommonPlayingPodcastBlocState> emit) async {
    await myAssetAudioPlayer.seek(Duration(seconds: event.value));
  }

  FutureOr<void> _seekByEvent(
      SeekByEvent event, Emitter<CommonPlayingPodcastBlocState> emit) async {
    await myAssetAudioPlayer.seekBy(Duration(seconds: event.value));
  }

  FutureOr<void> _getPodcastLikesUser(PodcastLikesUsersGetEvent event,
      Emitter<CommonPlayingPodcastBlocState> emit) async {
    emit(state.copyWith(
        podcastsUsersLikesRequestStatus:
            PodcastsUsersLikesRequestStatus.loading));
    final result = await podcastLikesUsersUsecase(
        PodcastLikesUsersparams(event.accessToken, event.podcastId));
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            podcastsUsersLikesRequestStatus:
                PodcastsUsersLikesRequestStatus.error)),
        (r) => emit(state.copyWith(
            podcastLikesUsersEntitie: r,
            errorMessage: '',
            podcastsUsersLikesRequestStatus:
                PodcastsUsersLikesRequestStatus.success)));
  }

  FutureOr<void> _downloadPodcast(PodcastDownloadEvent event,
      Emitter<CommonPlayingPodcastBlocState> emit) async {
    if (await checkPermissions()) {
      emit(state.copyWith(
          podcastDownloadRequestStatus: PodcastDownloadRequestStatus.loading));
      currentDownloadingPodcastId = event.podcastId;
      final result = await podcastDownloadUsecase(PodcastDownloadParams(
          podcastUrl: event.podcastUrl,
          savedPath: event.savedPath,
          receivedData: event.downloadProgress));
      result.fold((l) {
        emit(state.copyWith(
            errorMessage: l.message,
            podcastDownloadRequestStatus: PodcastDownloadRequestStatus.error));
        currentDownloadingPodcastId = '';
        downloadProgress.close();
      }, (r) {
        emit(
          state.copyWith(
            errorMessage: '',
            podcastDownloadRequestStatus:
                PodcastDownloadRequestStatus.downloaded,
          ),
        );
        currentDownloadingPodcastId = '';
        downloadProgress.close();
      });
    } else if (await checkPermissions() == false) {
      flutterToast(
          msg: 'Please Accept All Permissions',
          backgroundColor: AppColors.toastError,
          textColor: AppColors.white);
    }
  }

  Future<int> getAndroidVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  }

  Future<bool> checkPermissions() async {
    bool isPermissionGranted = false;
    if (await getAndroidVersion() > 29) {
      if (await Permission.storage.isGranted &&
          await Permission.accessMediaLocation.isGranted &&
          await Permission.manageExternalStorage.isGranted) {
        isPermissionGranted = true;
      } else {
        await Permission.storage.request();
        await Permission.accessMediaLocation.request();
        await Permission.manageExternalStorage.request();
      }
    } else {
      if (await Permission.storage.isGranted &&
          await Permission.accessMediaLocation.isGranted) {
        isPermissionGranted = true;
      } else {
        await Permission.storage.request();
        await Permission.accessMediaLocation.request();
      }
    }
    return isPermissionGranted;
  }

  File getSavedPath({required String podcastName}) {
    final directory = Directory('/storage/emulated/0/Youtube Downloader');
    final removeOrSymbole = podcastName.replaceAll('|', '');
    final fileName = removeOrSymbole.replaceAll('/', '');
    final file = File('${directory.path}/($fileName).mp3');
    return file;
  }

  FutureOr<void> _addLike(LikeAddMyPodcastEvent event,
      Emitter<CommonPlayingPodcastBlocState> emit) async {
    final result = await likeAddMyPodcastsUsecast(LikeAddMyPodcastsParams(
        accessToken: event.accessToken, podcastId: event.podcastId));
    result.fold((l) => emit(state.copyWith(errorMessage: l.message)), (r) {
      add(AddPodcastLikeIdToMapEvent(
          isLiked: true, podcastId: event.podcastId));
    });
  }

  FutureOr<void> _removeLike(LikeRemoveMyPodcastEvent event,
      Emitter<CommonPlayingPodcastBlocState> emit) async {
    final result = await likeRemoveMyPodcastsUsecast(LikeRemoveMyPodcastsParams(
        accessToken: event.accessToken, podcastId: event.podcastId));
    result.fold((l) => emit(state.copyWith(errorMessage: l.message)), (r) {
      add(AddPodcastLikeIdToMapEvent(
          isLiked: false, podcastId: event.podcastId));
    });
  }

  FutureOr<void> _addPodcastLikeIdToMap(AddPodcastLikeIdToMapEvent event,
      Emitter<CommonPlayingPodcastBlocState> emit) {
    Map<String, bool>? myLikesMap = Map.from(state.podcastsLikesStatus ?? {});
    if (myLikesMap == {} || myLikesMap.isEmpty) {
      myLikesMap = {};
      myLikesMap[event.podcastId] = event.isLiked;
      emit(state.copyWith(podcastsLikesStatus: myLikesMap));
    } else {
      myLikesMap[event.podcastId] = event.isLiked;
      emit(state.copyWith(podcastsLikesStatus: myLikesMap));
    }
  }

  void onPressedOnLikeLogic(
      {required bool serverLikeStatus,
      required Map<String, bool>? podcastLocalStatus,
      required String podcastId}) {
    if ((podcastLocalStatus != null && podcastLocalStatus.isNotEmpty) &&
        podcastLocalStatus.containsKey(podcastId)) {
      if (podcastLocalStatus[podcastId]!) {
        add(
          LikeRemoveMyPodcastEvent(
            accessToken: ConstVar.accessToken,
            podcastId: podcastId,
          ),
        );
      } else {
        add(
          LikeAddMyPodcastEvent(
            accessToken: ConstVar.accessToken,
            podcastId: podcastId,
          ),
        );
      }
    } else {
      if (serverLikeStatus) {
        add(
          LikeRemoveMyPodcastEvent(
            accessToken: ConstVar.accessToken,
            podcastId: podcastId,
          ),
        );
      } else {
        add(
          LikeAddMyPodcastEvent(
            accessToken: ConstVar.accessToken,
            podcastId: podcastId,
          ),
        );
      }
    }
  }
}
