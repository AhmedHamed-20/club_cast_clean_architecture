// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'common_playing_podcast_bloc_bloc.dart';

class CommonPlayingPodcastBlocState extends Equatable {
  final PlayPodcastRequestStatus playPodcastRequestStatus;
  final String errorMessage;
  final bool isPlaying;
  final int currentPosition;
  final List<PaletteColor> backGroundColors;
  final List<PodcastLikesUsersInfoEntitie> podcastLikesUsersEntitie;
  final PodcastsUsersLikesRequestStatus podcastsUsersLikesRequestStatus;
  final BackGroundColorGenerateRequestStatus
      podcastInfoScreenColorsGenerateRequestStatus;
  final PodcastDownloadRequestStatus podcastDownloadRequestStatus;
  final Map<String, bool>? podcastsLikesStatus;
  final BasePodcastEntitie currentPlayingPodcastEntitie;
  const CommonPlayingPodcastBlocState(
      {this.playPodcastRequestStatus = PlayPodcastRequestStatus.idle,
      this.errorMessage = '',
      this.podcastsLikesStatus,
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
    Map<String, bool>? podcastsLikesStatus,
    PodcastDownloadRequestStatus? podcastDownloadRequestStatus,
    List<PaletteColor>? backGroundColors,
    BackGroundColorGenerateRequestStatus?
        podcastInfoScreenColorsGenerateRequestStatus,
    int? currentPosition,
    List<PodcastLikesUsersInfoEntitie>? podcastLikesUsersEntitie,
    PodcastsUsersLikesRequestStatus? podcastsUsersLikesRequestStatus,
    PlayPodcastRequestStatus? playPodcastRequestStatus,
    String? errorMessage,
    bool? isPlaying,
    BasePodcastEntitie? currentPlayingPodcastEntitie,
  }) {
    return CommonPlayingPodcastBlocState(
      currentPlayingPodcastEntitie:
          currentPlayingPodcastEntitie ?? this.currentPlayingPodcastEntitie,
      podcastsLikesStatus: podcastsLikesStatus ?? this.podcastsLikesStatus,
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
        currentPosition,
        errorMessage,
        currentPlayingPodcastEntitie,
        podcastsLikesStatus,
        backGroundColors,
        podcastDownloadRequestStatus,
        playPodcastRequestStatus,
        isPlaying,
        podcastInfoScreenColorsGenerateRequestStatus,
        podcastLikesUsersEntitie,
        podcastsUsersLikesRequestStatus,
      ];
}
