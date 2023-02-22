part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String errorMessages;
  final int statusCode;
  final SearchRequestStatus roomsSearchRequestStatus;
  final SearchRequestStatus podcastSearchRequestStatus;
  final SearchRequestStatus usersSearchRequestStatus;
  final List<SearchRoomsEntitie> roomsSearchEntitie;
  final List<SearchUsersEntite> usersSearchEntitie;
  final PodcastSearchEntitie podcastSearchEntitie;
  const SearchState({
    this.errorMessages = '',
    this.statusCode = 0,
    this.roomsSearchRequestStatus = SearchRequestStatus.idle,
    this.podcastSearchRequestStatus = SearchRequestStatus.idle,
    this.usersSearchRequestStatus = SearchRequestStatus.idle,
    this.roomsSearchEntitie = const [],
    this.usersSearchEntitie = const [],
    this.podcastSearchEntitie =
        const PodcastSearchEntitie(results: 0, podcastInformationEntitie: []),
  });

  SearchState copyWith({
    String? errorMessages,
    int? statusCode,
    SearchRequestStatus? roomsSearchRequestStatus,
    SearchRequestStatus? podcastSearchRequestStatus,
    SearchRequestStatus? usersSearchRequestStatus,
    List<SearchRoomsEntitie>? roomsSearchEntitie,
    List<SearchUsersEntite>? usersSearchEntitie,
    PodcastSearchEntitie? podcastSearchEntitie,
  }) {
    return SearchState(
      errorMessages: errorMessages ?? this.errorMessages,
      statusCode: statusCode ?? this.statusCode,
      roomsSearchRequestStatus:
          roomsSearchRequestStatus ?? this.roomsSearchRequestStatus,
      podcastSearchRequestStatus:
          podcastSearchRequestStatus ?? this.podcastSearchRequestStatus,
      usersSearchRequestStatus:
          usersSearchRequestStatus ?? this.usersSearchRequestStatus,
      roomsSearchEntitie: roomsSearchEntitie ?? this.roomsSearchEntitie,
      usersSearchEntitie: usersSearchEntitie ?? this.usersSearchEntitie,
      podcastSearchEntitie: podcastSearchEntitie ?? this.podcastSearchEntitie,
    );
  }

  @override
  List<Object> get props => [
        errorMessages,
        statusCode,
        roomsSearchRequestStatus,
        podcastSearchRequestStatus,
        usersSearchRequestStatus,
        roomsSearchEntitie,
        usersSearchEntitie,
        podcastSearchEntitie,
      ];
}
