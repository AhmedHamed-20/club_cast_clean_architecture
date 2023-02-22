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
