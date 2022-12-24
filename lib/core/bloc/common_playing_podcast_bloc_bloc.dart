import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
        nextEnabled: false,
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
}