// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'common_playing_podcast_bloc_bloc.dart';

class CommonPlayingPodcastBlocState extends Equatable {
  final PlayPodcastRequestStatus playPodcastRequestStatus;
  final String errorMessage;
  final bool isPlaying;
  final int currentPosition;
  final PodcastLikeStatus podcastLikeStatus;
  final List<PaletteColor> backGroundColors;
  final List<PodcastLikesUsersInfoEntity> podcastLikesUsersEntitie;
  final PodcastsUsersLikesRequestStatus podcastsUsersLikesRequestStatus;
  final BackGroundColorGenerateRequestStatus
      podcastInfoScreenColorsGenerateRequestStatus;
  final PodcastDownloadRequestStatus podcastDownloadRequestStatus;
  final Map<String, bool>? podcastsLikesStatusMap;
  final BasePodcastEntitie currentPlayingPodcastEntitie;
  const CommonPlayingPodcastBlocState(
      {this.playPodcastRequestStatus = PlayPodcastRequestStatus.idle,
      this.errorMessage = '',
      this.podcastsLikesStatusMap,
      this.podcastLikeStatus = PodcastLikeStatus.idle,
      this.currentPlayingPodcastEntitie =
          DefaultsValues.basePodcastEntitieDefaultValues,
      this.podcastLikesUsersEntitie = const [],
      this.podcastsUsersLikesRequestStatus =
          PodcastsUsersLikesRequestStatus.loading,
      this.podcastDownloadRequestStatus = PodcastDownloadRequestStatus.idle,
      this.currentPosition = 0,
      this.backGroundColors = const [],
      this.podcastInfoScreenColorsGenerateRequestStatus =
          BackGroundColorGenerateRequestStatus.loading,
      this.isPlaying = false});

  CommonPlayingPodcastBlocState copyWith({
    PodcastLikeStatus? podcastLikeStatus,
    Map<String, bool>? podcastsLikesStatusMap,
    PodcastDownloadRequestStatus? podcastDownloadRequestStatus,
    List<PaletteColor>? backGroundColors,
    BackGroundColorGenerateRequestStatus?
        podcastInfoScreenColorsGenerateRequestStatus,
    int? currentPosition,
    List<PodcastLikesUsersInfoEntity>? podcastLikesUsersEntitie,
    PodcastsUsersLikesRequestStatus? podcastsUsersLikesRequestStatus,
    PlayPodcastRequestStatus? playPodcastRequestStatus,
    String? errorMessage,
    bool? isPlaying,
    BasePodcastEntitie? currentPlayingPodcastEntitie,
  }) {
    return CommonPlayingPodcastBlocState(
      podcastLikeStatus: podcastLikeStatus ?? this.podcastLikeStatus,
      currentPlayingPodcastEntitie:
          currentPlayingPodcastEntitie ?? this.currentPlayingPodcastEntitie,
      podcastsLikesStatusMap:
          podcastsLikesStatusMap ?? this.podcastsLikesStatusMap,
      podcastDownloadRequestStatus:
          podcastDownloadRequestStatus ?? this.podcastDownloadRequestStatus,
      podcastLikesUsersEntitie:
          podcastLikesUsersEntitie ?? this.podcastLikesUsersEntitie,
      podcastsUsersLikesRequestStatus: podcastsUsersLikesRequestStatus ??
          this.podcastsUsersLikesRequestStatus,
      backGroundColors: backGroundColors ?? this.backGroundColors,
      podcastInfoScreenColorsGenerateRequestStatus:
          podcastInfoScreenColorsGenerateRequestStatus ??
              this.podcastInfoScreenColorsGenerateRequestStatus,
      currentPosition: currentPosition ?? this.currentPosition,
      playPodcastRequestStatus:
          playPodcastRequestStatus ?? this.playPodcastRequestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object?> get props => [
        podcastLikeStatus,
        currentPosition,
        errorMessage,
        currentPlayingPodcastEntitie,
        podcastsLikesStatusMap,
        backGroundColors,
        podcastDownloadRequestStatus,
        playPodcastRequestStatus,
        isPlaying,
        podcastInfoScreenColorsGenerateRequestStatus,
        podcastLikesUsersEntitie,
        podcastsUsersLikesRequestStatus,
      ];
}
