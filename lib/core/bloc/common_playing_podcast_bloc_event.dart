part of 'common_playing_podcast_bloc_bloc.dart';

abstract class CommonPlayingPodcastBlocEvent extends Equatable {
  const CommonPlayingPodcastBlocEvent();
}

class PodcastPlayEvent extends CommonPlayingPodcastBlocEvent {
  final String podcastName;
  final String podcastUserName;
  final String podcastUrl;
  final String podcastId;
  final String podcastPhoto;
  const PodcastPlayEvent(
      {required this.podcastUrl,
      required this.podcastId,
      required this.podcastName,
      required this.podcastPhoto,
      required this.podcastUserName});

  @override
  List<Object?> get props =>
      [podcastUrl, podcastId, podcastName, podcastUserName, podcastPhoto];
}

class PodcastPausePlaying extends CommonPlayingPodcastBlocEvent {
  final String podcastId;

  const PodcastPausePlaying(this.podcastId);

  @override
  List<Object?> get props => [];
}

class PodcastPlayPaused extends CommonPlayingPodcastBlocEvent {
  final String podcastId;

  const PodcastPlayPaused(this.podcastId);

  @override
  List<Object?> get props => [];
}

class PodcastStopPlaying extends CommonPlayingPodcastBlocEvent {
  final String podcastId;

  const PodcastStopPlaying(this.podcastId);
  @override
  List<Object?> get props => [podcastId];
}

class CurrentPositionChangeValueEvent extends CommonPlayingPodcastBlocEvent {
  final int currentPosition;

  const CurrentPositionChangeValueEvent(this.currentPosition);

  @override
  List<Object?> get props => [currentPosition];
}
