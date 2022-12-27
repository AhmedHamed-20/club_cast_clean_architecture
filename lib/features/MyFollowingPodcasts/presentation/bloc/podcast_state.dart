part of 'podcast_bloc.dart';

class PodcastState extends Equatable {
  final PodcastEntitie? myFollowingPodcasts;
  final List<PodcastLikesUsersInfoEntitie> podcastLikesUsersEntitie;
  final MyFollowingPodcastsRequestStatus myFollowingPodcastsRequestStatus;
  final MyFollowingPodcastsUsersLikesRequestStatus
      myFollowingPodcastsUsersLikesRequestStatus;
  final String errorMessage;
  final MyFollowingPodcastsRequestStatus moreMyFollowingPodcastsRequestStatus;
  final bool isEndOfData;
  final bool isPlaying;
  final PodcastDownloadRequestStatus podcastDownloadRequestStatus;
  const PodcastState(
      {this.myFollowingPodcasts,
      this.moreMyFollowingPodcastsRequestStatus =
          MyFollowingPodcastsRequestStatus.loading,
      this.podcastLikesUsersEntitie = const [],
      this.isPlaying = false,
      this.podcastDownloadRequestStatus = PodcastDownloadRequestStatus.idle,
      this.isEndOfData = false,
      this.myFollowingPodcastsRequestStatus =
          MyFollowingPodcastsRequestStatus.loading,
      this.myFollowingPodcastsUsersLikesRequestStatus =
          MyFollowingPodcastsUsersLikesRequestStatus.loading,
      this.errorMessage = ''});
  PodcastState copyWith({
    bool? isPlaying,
    PodcastDownloadRequestStatus? podcastDownloadRequestStatus,
    MyFollowingPodcastsRequestStatus? moreMyFollowingPodcastsRequestStatus,
    PodcastEntitie? myFollowingPodcasts,
    List<PodcastLikesUsersInfoEntitie>? podcastLikesUsersEntitie,
    MyFollowingPodcastsRequestStatus? myFollowingPodcastsRequestStatus,
    MyFollowingPodcastsUsersLikesRequestStatus?
        myFollowingPodcastsUsersLikesRequestStatus,
    String? errorMessage,
    bool? isEndOfData,
  }) {
    return PodcastState(
      podcastDownloadRequestStatus:
          podcastDownloadRequestStatus ?? this.podcastDownloadRequestStatus,
      isPlaying: isPlaying ?? this.isPlaying,
      isEndOfData: isEndOfData ?? this.isEndOfData,
      moreMyFollowingPodcastsRequestStatus:
          moreMyFollowingPodcastsRequestStatus ??
              this.moreMyFollowingPodcastsRequestStatus,
      myFollowingPodcasts: myFollowingPodcasts ?? this.myFollowingPodcasts,
      podcastLikesUsersEntitie:
          podcastLikesUsersEntitie ?? this.podcastLikesUsersEntitie,
      myFollowingPodcastsRequestStatus: myFollowingPodcastsRequestStatus ??
          this.myFollowingPodcastsRequestStatus,
      myFollowingPodcastsUsersLikesRequestStatus:
          myFollowingPodcastsUsersLikesRequestStatus ??
              this.myFollowingPodcastsUsersLikesRequestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        errorMessage,
        isPlaying,
        isEndOfData,
        moreMyFollowingPodcastsRequestStatus,
        podcastDownloadRequestStatus,
        myFollowingPodcasts,
        podcastLikesUsersEntitie,
        myFollowingPodcastsRequestStatus,
        myFollowingPodcastsUsersLikesRequestStatus
      ];
}
