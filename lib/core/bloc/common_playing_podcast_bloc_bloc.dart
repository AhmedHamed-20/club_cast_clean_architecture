import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:palette_generator/palette_generator.dart';

import '../constants/constants.dart';
import '../utl/utls.dart';

part 'common_playing_podcast_bloc_event.dart';
part 'common_playing_podcast_bloc_state.dart';

class CommonPlayingPodcastBlocBloc
    extends Bloc<CommonPlayingPodcastBlocEvent, CommonPlayingPodcastBlocState> {
  CommonPlayingPodcastBlocBloc()
      : super(const CommonPlayingPodcastBlocState()) {
    on<PodcastPlayEvent>(_playPodcast);
    on<PodcastPlayPaused>(_playPaused);
    on<PodcastPausePlaying>(_pausePlayingPodcast);
    on<PodcastStopPlaying>(_stopPlayingPodcast);
    on<CurrentPositionChangeValueEvent>(_changeCurrentPositionValue);
    on<PodcastBackGroundColorGenerateEvent>(_generateBackgroundColor);
    on<SeekToEvent>(_seekTo);
    on<SeekByEvent>(_seekByEvent);
  }
  late AssetsAudioPlayer myAssetAudioPlayer;

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
            PodcastInfoScreenColorsGenerateRequestStatus.loading,
        backGroundColors: const []));
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(event.image),
      maximumColorCount: 20,
    );
    if (paletteGenerator.colors.isNotEmpty) {
      paletteGenerator.paletteColors;
      emit(state.copyWith(
          podcastInfoScreenColorsGenerateRequestStatus:
              PodcastInfoScreenColorsGenerateRequestStatus.generated,
          backGroundColors: paletteGenerator.paletteColors));
    } else {
      emit(state.copyWith(
          podcastInfoScreenColorsGenerateRequestStatus:
              PodcastInfoScreenColorsGenerateRequestStatus.error,
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
}
