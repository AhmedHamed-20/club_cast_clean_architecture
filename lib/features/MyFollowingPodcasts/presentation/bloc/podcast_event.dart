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

class MoreMyFollowingPodcastsGetEvent extends PodcastEvent {
  final String accessToken;
  final String page;

  const MoreMyFollowingPodcastsGetEvent(
      {required this.accessToken, required this.page});
  @override
  List<Object?> get props => [page, accessToken];
}

class UpdatePodcastLikesCountEvent extends PodcastEvent {
  final bool isLiked;
  final String podcastId;

  const UpdatePodcastLikesCountEvent(
      {required this.isLiked, required this.podcastId});

  @override
  List<Object?> get props => [isLiked, podcastId];
}
