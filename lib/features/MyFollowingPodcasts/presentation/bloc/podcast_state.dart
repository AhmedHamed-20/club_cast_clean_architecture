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
  const PodcastState(
      {this.myFollowingPodcasts,
      this.moreMyFollowingPodcastsRequestStatus =
          MyFollowingPodcastsRequestStatus.loading,
      this.podcastLikesUsersEntitie = const [],
      this.isEndOfData = false,
      this.myFollowingPodcastsRequestStatus =
          MyFollowingPodcastsRequestStatus.loading,
      this.myFollowingPodcastsUsersLikesRequestStatus =
          MyFollowingPodcastsUsersLikesRequestStatus.loading,
      this.errorMessage = ''});
  PodcastState copyWith({
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
        isEndOfData,
        moreMyFollowingPodcastsRequestStatus,
        myFollowingPodcasts,
        podcastLikesUsersEntitie,
        myFollowingPodcastsRequestStatus,
        myFollowingPodcastsUsersLikesRequestStatus
      ];
}
