part of 'common_playing_podcast_bloc_bloc.dart';

abstract class CommonPlayingPodcastBlocEvent extends Equatable {
  const CommonPlayingPodcastBlocEvent();
}

class PodcastPlayEvent extends CommonPlayingPodcastBlocEvent {
  final BasePodcastEntitie basePodcastEntitie;
  const PodcastPlayEvent({
    required this.basePodcastEntitie,
  });

  @override
  List<Object?> get props => [basePodcastEntitie];
}

class PodcastPausePlaying extends CommonPlayingPodcastBlocEvent {
  final String podcastId;

  const PodcastPausePlaying(this.podcastId);

  @override
  List<Object?> get props => [podcastId];
}

class PodcastPlayPaused extends CommonPlayingPodcastBlocEvent {
  final String podcastId;
  const PodcastPlayPaused(
    this.podcastId,
  );

  @override
  List<Object?> get props => [
        podcastId,
      ];
}

class PodcastStopPlaying extends CommonPlayingPodcastBlocEvent {
  final String podcastId;
  const PodcastStopPlaying(
    this.podcastId,
  );
  @override
  List<Object?> get props => [
        podcastId,
      ];
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

class LikeAddMyPodcastEvent extends CommonPlayingPodcastBlocEvent {
  final String accessToken;
  final String podcastId;

  const LikeAddMyPodcastEvent(
      {required this.accessToken, required this.podcastId});

  @override
  List<Object?> get props => [accessToken, podcastId];
}

class LikeRemoveMyPodcastEvent extends CommonPlayingPodcastBlocEvent {
  final String accessToken;
  final String podcastId;

  const LikeRemoveMyPodcastEvent(
      {required this.accessToken, required this.podcastId});

  @override
  List<Object?> get props => [accessToken, podcastId];
}

class AddPodcastLikeIdToMapEvent extends CommonPlayingPodcastBlocEvent {
  final String podcastId;
  final bool isLiked;

  const AddPodcastLikeIdToMapEvent(
      {required this.podcastId, required this.isLiked});

  @override
  List<Object?> get props => [podcastId, isLiked];
}
