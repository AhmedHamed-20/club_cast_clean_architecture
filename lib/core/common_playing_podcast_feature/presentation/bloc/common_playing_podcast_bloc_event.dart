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

class PodcastBackGroundColorGenerateEvent
    extends CommonPlayingPodcastBlocEvent {
  final String image;

  const PodcastBackGroundColorGenerateEvent(this.image);

  @override
  List<Object?> get props => [image];
}

class SeekToEvent extends CommonPlayingPodcastBlocEvent {
  final int value;

  const SeekToEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class SeekByEvent extends CommonPlayingPodcastBlocEvent {
  final int value;

  const SeekByEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class PodcastLikesUsersGetEvent extends CommonPlayingPodcastBlocEvent {
  final String accessToken;
  final String podcastId;

  const PodcastLikesUsersGetEvent(this.accessToken, this.podcastId);

  @override
  List<Object?> get props => [accessToken, podcastId];
}

class PodcastDownloadEvent extends CommonPlayingPodcastBlocEvent {
  final String podcastUrl;
  final String savedPath;
  final StreamController downloadProgress;
  final String podcastId;
  const PodcastDownloadEvent(
      {required this.podcastUrl,
      required this.savedPath,
      required this.podcastId,
      required this.downloadProgress});

  @override
  List<Object?> get props =>
      [podcastId, podcastUrl, savedPath, downloadProgress];
}
