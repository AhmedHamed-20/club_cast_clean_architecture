// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'common_playing_podcast_bloc_bloc.dart';

class CommonPlayingPodcastBlocState extends Equatable {
  final PlayPodcastRequestStatus playPodcastRequestStatus;
  final String errorMessage;
  final bool isPlaying;
  final int currentPosition;
  const CommonPlayingPodcastBlocState(
      {this.playPodcastRequestStatus = PlayPodcastRequestStatus.idle,
      this.errorMessage = '',
      this.currentPosition = 0,
      this.isPlaying = false});

  CommonPlayingPodcastBlocState copyWith({
    int? currentPosition,
    PlayPodcastRequestStatus? playPodcastRequestStatus,
    String? errorMessage,
    bool? isPlaying,
  }) {
    return CommonPlayingPodcastBlocState(
      currentPosition: currentPosition ?? this.currentPosition,
      playPodcastRequestStatus:
          playPodcastRequestStatus ?? this.playPodcastRequestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object> get props =>
      [currentPosition, errorMessage, playPodcastRequestStatus, isPlaying];
}
