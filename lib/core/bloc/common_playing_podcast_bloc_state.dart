// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'common_playing_podcast_bloc_bloc.dart';

class CommonPlayingPodcastBlocState extends Equatable {
  final PlayPodcastRequestStatus playPodcastRequestStatus;
  final String errorMessage;
  final bool isPlaying;

  const CommonPlayingPodcastBlocState(
      {this.playPodcastRequestStatus = PlayPodcastRequestStatus.idle,
      this.errorMessage = '',
      this.isPlaying = false});

  CommonPlayingPodcastBlocState copyWith({
    PlayPodcastRequestStatus? playPodcastRequestStatus,
    String? errorMessage,
    bool? isPlaying,
  }) {
    return CommonPlayingPodcastBlocState(
      playPodcastRequestStatus:
          playPodcastRequestStatus ?? this.playPodcastRequestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object> get props => [errorMessage, playPodcastRequestStatus, isPlaying];
}
