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
