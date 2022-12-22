part of 'podcast_bloc.dart';

abstract class PodcastEvent extends Equatable {
  const PodcastEvent();
}

class GetMyFollowingPodcastsEvent extends PodcastEvent {
  final String accessToken;
  const GetMyFollowingPodcastsEvent({required this.accessToken});
  @override
  List<Object> get props => [accessToken];
}

class AddLikeToPodcastEvent extends PodcastEvent {
  final String accessToken;
  final String podcastId;
  const AddLikeToPodcastEvent(
      {required this.accessToken, required this.podcastId});
  @override
  List<Object> get props => [accessToken, podcastId];
}

class GetPodcastLikesUsersEvent extends PodcastEvent {
  final String accessToken;
  final String podcastId;
  const GetPodcastLikesUsersEvent(
      {required this.accessToken, required this.podcastId});
  @override
  List<Object> get props => [accessToken, podcastId];
}

class RemovePodcastLikeEvent extends PodcastEvent {
  final String accessToken;
  final String podcastId;
  const RemovePodcastLikeEvent(
      {required this.accessToken, required this.podcastId});
  @override
  List<Object> get props => [accessToken, podcastId];
}

class MoreMyFollowingPodcastsGetEvent extends PodcastEvent {
  final String accessToken;
  final String page;

  const MoreMyFollowingPodcastsGetEvent(
      {required this.accessToken, required this.page});
  @override
  List<Object?> get props => [page, accessToken];
}
