import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/usecases/download_podcast.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/usecases/get_podcast_likes_users.dart';
import 'package:club_cast_clean_architecture/core/constants/default_values.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../constants/base_podcast_entitie/base_podcast_entitie.dart';
import '../../../constants/constants.dart';
import '../../../constants/storage_permission_download_path.dart';
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
    this.layoutBloc,
    this.likeAddMyPodcastsUsecast,
    this.likeRemoveMyPodcastsUsecast,
    this.myAssetAudioPlayer,
  ) : super(const CommonPlayingPodcastBlocState()) {
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
  final AssetsAudioPlayer myAssetAudioPlayer;
  final PodcastLikesUsersUsecase podcastLikesUsersUsecase;
  final PodcastDownloadUsecase podcastDownloadUsecase;
  final LikeAddMyPodcastsUsecast likeAddMyPodcastsUsecast;
  final LikeRemoveMyPodcastsUsecast likeRemoveMyPodcastsUsecast;
  final LayoutBloc layoutBloc;
  FutureOr<void> _playPodcast(PodcastPlayEvent event,
      Emitter<CommonPlayingPodcastBlocState> emit) async {
    if (ConstVar.layoutBottomSheetStatus !=
        LayoutBottomSheetStatus.playingLiveVoiceRoom) {
      if (myAssetAudioPlayer.isPlaying.value) {
        add(PodcastStopPlaying(
          event.basePodcastEntitie.podcastId,
        ));
      }

      await myAssetAudioPlayer.open(
        Audio.network(
          event.basePodcastEntitie.podcastInfo.podcastUrl,
          metas: Metas(
            title: event.basePodcastEntitie.podcastName,
            artist: event.basePodcastEntitie.podcastUserInfo.userName,
            image: MetasImage(
              path: event.basePodcastEntitie.podcastUserInfo.userImage,
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
              add(PodcastPausePlaying(event.basePodcastEntitie.podcastId));
            } else {
              add(PodcastPlayPaused(event.basePodcastEntitie.podcastId));
            }
          },
          customStopAction: (player) {
            add(PodcastStopPlaying(
              event.basePodcastEntitie.podcastId,
            ));
          },
          seekBarEnabled: true,
        ),
      );
      if (myAssetAudioPlayer.isPlaying.value) {
        currentPlayingPodcastsId = event.basePodcastEntitie.podcastId;
        currentPausePodcastsId = '';

        emit(
          state.copyWith(
            isPlaying: true,
            playPodcastRequestStatus: PlayPodcastRequestStatus.playing,
            currentPlayingPodcastEntitie: event.basePodcastEntitie,
          ),
        );
        layoutBloc.add(const BottomSheetStatusEvent(
            layoutBottomSheetStatus: LayoutBottomSheetStatus.playingPodcast));
      }
      myAssetAudioPlayer.currentPosition.listen(
        (event) {
          add(CurrentPositionChangeValueEvent(event.inSeconds));
        },
      );
    } else {
      flutterToast(
          msg: 'you can not play podcast while you are in live voice room',
          backgroundColor: AppColors.toastWarning,
          textColor: AppColors.black);
    }
  }

  FutureOr<void> _playPaused(PodcastPlayPaused event,
      Emitter<CommonPlayingPodcastBlocState> emit) async {
    await myAssetAudioPlayer.play();
    if (myAssetAudioPlayer.isPlaying.value) {
      currentPlayingPodcastsId = event.podcastId;
      currentPausePodcastsId = '';
      emit(state.copyWith(
          isPlaying: true,
          playPodcastRequestStatus: PlayPodcastRequestStatus.playing));
    }
  }

  FutureOr<void> _pausePlayingPodcast(PodcastPausePlaying event,
      Emitter<CommonPlayingPodcastBlocState> emit) async {
    await myAssetAudioPlayer.pause();
    if (myAssetAudioPlayer.isPlaying.value == false) {
      currentPlayingPodcastsId = '';
      currentPausePodcastsId = event.podcastId;
      emit(state.copyWith(
          isPlaying: false,
          playPodcastRequestStatus: PlayPodcastRequestStatus.paused));
    }
  }

  FutureOr<void> _stopPlayingPodcast(PodcastStopPlaying event,
      Emitter<CommonPlayingPodcastBlocState> emit) async {
    await myAssetAudioPlayer.stop();
    if (myAssetAudioPlayer.isPlaying.value == false) {
      currentPlayingPodcastsId = '';
      currentPausePodcastsId = '';
      emit(state.copyWith(
          isPlaying: false,
          playPodcastRequestStatus: PlayPodcastRequestStatus.stoped,
          currentPlayingPodcastEntitie:
              DefaultsValues.basePodcastEntitieDefaultValues));
    }
    layoutBloc.add(
      const BottomSheetStatusEvent(
        layoutBottomSheetStatus: LayoutBottomSheetStatus.idle,
      ),
    );
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
      {required BasePodcastEntitie basePodcastEntitie,
      required BuildContext context}) {
    if (currentPlayingPodcastsId == basePodcastEntitie.podcastId) {
      add(PodcastPausePlaying(basePodcastEntitie.podcastId));
    } else if (currentPausePodcastsId == basePodcastEntitie.podcastId) {
      add(PodcastPlayPaused(basePodcastEntitie.podcastId));
    } else {
      showSnackBar(context: context, text: 'loading');
      add(
        PodcastPlayEvent(basePodcastEntitie: basePodcastEntitie),
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
    if (await StoragePermissionAndPath.checkStoragePermissions()) {
      emit(state.copyWith(
          podcastDownloadRequestStatus: PodcastDownloadRequestStatus.loading));
      currentDownloadingPodcastId = event.podcastId;
      final result = await podcastDownloadUsecase(
        PodcastDownloadParams(
          podcastUrl: event.podcastUrl,
          savedPath: event.savedPath,
          receivedData: event.downloadProgress,
        ),
      );
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
        flutterToast(
            msg: 'Download Completed and saved in club cast folder',
            backgroundColor: AppColors.toastSuccess,
            textColor: AppColors.white);
        currentDownloadingPodcastId = '';
        downloadProgress.close();
      });
    } else if (await StoragePermissionAndPath.checkStoragePermissions() ==
        false) {
      flutterToast(
          msg: 'Please Accept All Permissions',
          backgroundColor: AppColors.toastError,
          textColor: AppColors.white);
    }
  }

  FutureOr<void> _addLike(LikeAddMyPodcastEvent event,
      Emitter<CommonPlayingPodcastBlocState> emit) async {
    if (state.podcastLikeStatus == PodcastLikeStatus.loading) {
      return;
    }
    emit(state.copyWith(podcastLikeStatus: PodcastLikeStatus.loading));
    final result = await likeAddMyPodcastsUsecast(LikeAddMyPodcastsParams(
        accessToken: event.accessToken, podcastId: event.podcastId));
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            podcastLikeStatus: PodcastLikeStatus.error)), (r) {
      add(
        AddPodcastLikeIdToMapEvent(
          isLiked: true,
          podcastId: event.podcastId,
        ),
      );
    });
  }

  FutureOr<void> _removeLike(LikeRemoveMyPodcastEvent event,
      Emitter<CommonPlayingPodcastBlocState> emit) async {
    if (state.podcastLikeStatus == PodcastLikeStatus.loading) {
      return;
    }
    emit(state.copyWith(podcastLikeStatus: PodcastLikeStatus.loading));
    final result = await likeRemoveMyPodcastsUsecast(LikeRemoveMyPodcastsParams(
        accessToken: event.accessToken, podcastId: event.podcastId));
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            podcastLikeStatus: PodcastLikeStatus.error)), (r) {
      add(AddPodcastLikeIdToMapEvent(
          isLiked: false, podcastId: event.podcastId));
    });
  }

  FutureOr<void> _addPodcastLikeIdToMap(AddPodcastLikeIdToMapEvent event,
      Emitter<CommonPlayingPodcastBlocState> emit) {
    Map<String, bool>? myLikesMap =
        Map.from(state.podcastsLikesStatusMap ?? {});
    if (myLikesMap == {} || myLikesMap.isEmpty) {
      myLikesMap = {};
      myLikesMap[event.podcastId] = event.isLiked;
      emit(state.copyWith(
          podcastsLikesStatusMap: myLikesMap,
          podcastLikeStatus: event.isLiked
              ? PodcastLikeStatus.liked
              : PodcastLikeStatus.unliked));
    } else {
      myLikesMap[event.podcastId] = event.isLiked;
      emit(state.copyWith(
          podcastsLikesStatusMap: myLikesMap,
          podcastLikeStatus: event.isLiked
              ? PodcastLikeStatus.liked
              : PodcastLikeStatus.unliked));
    }
  }

  void onPressedOnLikeLogic(
      {required bool serverLikeStatus,
      required Map<String, bool>? podcastLocalStatus,
      required String podcastId,
      required Bloc podcastBloc,
      required dynamic podcastCountEvent}) {
    if ((podcastLocalStatus != null && podcastLocalStatus.isNotEmpty) &&
        podcastLocalStatus.containsKey(podcastId)) {
      if (podcastLocalStatus[podcastId]!) {
        add(
          LikeRemoveMyPodcastEvent(
            accessToken: ConstVar.accessToken,
            podcastId: podcastId,
          ),
        );

        podcastBloc.add(podcastCountEvent);
      } else {
        add(
          LikeAddMyPodcastEvent(
            accessToken: ConstVar.accessToken,
            podcastId: podcastId,
          ),
        );
        podcastBloc.add(podcastCountEvent);
      }
    } else {
      if (serverLikeStatus) {
        add(
          LikeRemoveMyPodcastEvent(
            accessToken: ConstVar.accessToken,
            podcastId: podcastId,
          ),
        );
        podcastBloc.add(podcastCountEvent);
      } else {
        add(
          LikeAddMyPodcastEvent(
            accessToken: ConstVar.accessToken,
            podcastId: podcastId,
          ),
        );
        podcastBloc.add(podcastCountEvent);
      }
    }
  }
}
