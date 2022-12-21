part of 'podcast_bloc.dart';

class PodcastState extends Equatable {
  final List<PodcastEntitie> myFollowingPodcasts;
  final List<PodcastLikesUsersInfoEntitie> podcastLikesUsersEntitie;
  final MyFollowingPodcastsRequestStatus myFollowingPodcastsRequestStatus;
  final MyFollowingPodcastsUsersLikesRequestStatus
      myFollowingPodcastsUsersLikesRequestStatus;
  final String errorMessage;

  const PodcastState(
      {this.myFollowingPodcasts = const [],
      this.podcastLikesUsersEntitie = const [],
      this.myFollowingPodcastsRequestStatus =
          MyFollowingPodcastsRequestStatus.loading,
      this.myFollowingPodcastsUsersLikesRequestStatus =
          MyFollowingPodcastsUsersLikesRequestStatus.loading,
      this.errorMessage = ''});
  PodcastState copyWith({
    List<PodcastEntitie>? myFollowingPodcasts,
    List<PodcastLikesUsersInfoEntitie>? podcastLikesUsersEntitie,
    MyFollowingPodcastsRequestStatus? myFollowingPodcastsRequestStatus,
    MyFollowingPodcastsUsersLikesRequestStatus?
        myFollowingPodcastsUsersLikesRequestStatus,
    String? errorMessage,
  }) {
    return PodcastState(
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
  List<Object> get props => [
        errorMessage,
        myFollowingPodcasts,
        podcastLikesUsersEntitie,
        myFollowingPodcastsRequestStatus,
        myFollowingPodcastsUsersLikesRequestStatus
      ];
}
