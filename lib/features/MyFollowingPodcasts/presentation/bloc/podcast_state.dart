part of 'podcast_bloc.dart';

class PodcastState extends Equatable {
  final PodcastEntitie? myFollowingPodcasts;
  final MyFollowingPodcastsRequestStatus myFollowingPodcastsRequestStatus;

  final String errorMessage;
  final MyFollowingPodcastsRequestStatus moreMyFollowingPodcastsRequestStatus;
  final bool isEndOfData;
  final bool isPlaying;
  final PodcastDownloadRequestStatus podcastDownloadRequestStatus;
  const PodcastState(
      {this.myFollowingPodcasts,
      this.moreMyFollowingPodcastsRequestStatus =
          MyFollowingPodcastsRequestStatus.loading,
      this.isPlaying = false,
      this.podcastDownloadRequestStatus = PodcastDownloadRequestStatus.idle,
      this.isEndOfData = false,
      this.myFollowingPodcastsRequestStatus =
          MyFollowingPodcastsRequestStatus.loading,
      this.errorMessage = ''});
  PodcastState copyWith({
    bool? isPlaying,
    PodcastDownloadRequestStatus? podcastDownloadRequestStatus,
    MyFollowingPodcastsRequestStatus? moreMyFollowingPodcastsRequestStatus,
    PodcastEntitie? myFollowingPodcasts,
    MyFollowingPodcastsRequestStatus? myFollowingPodcastsRequestStatus,
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
      myFollowingPodcastsRequestStatus: myFollowingPodcastsRequestStatus ??
          this.myFollowingPodcastsRequestStatus,
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
        myFollowingPodcastsRequestStatus,
      ];
}
