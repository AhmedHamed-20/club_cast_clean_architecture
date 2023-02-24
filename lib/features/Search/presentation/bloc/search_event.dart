part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class RoomsSearchEvent extends SearchEvent {
  final String query;
  final String accessToken;

  const RoomsSearchEvent({required this.query, required this.accessToken});

  @override
  List<Object> get props => [query, accessToken];
}

class PodcastSearchEvent extends SearchEvent {
  final String query;
  final String accessToken;

  const PodcastSearchEvent({required this.query, required this.accessToken});

  @override
  List<Object> get props => [query, accessToken];
}

class UsersSearchEvent extends SearchEvent {
  final String query;
  final String accessToken;

  const UsersSearchEvent({required this.query, required this.accessToken});

  @override
  List<Object> get props => [query, accessToken];
}

class AllPodcastEvent extends SearchEvent {
  final String accessToken;
  final int page;

  const AllPodcastEvent({required this.accessToken, required this.page});

  @override
  List<Object> get props => [accessToken, page];
}

class AllPodcastGetMoreEvent extends SearchEvent {
  final String accessToken;
  final int page;

  const AllPodcastGetMoreEvent({required this.accessToken, required this.page});

  @override
  List<Object> get props => [accessToken, page];
}
