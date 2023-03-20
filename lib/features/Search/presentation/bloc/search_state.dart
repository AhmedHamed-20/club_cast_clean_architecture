part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String errorMessages;
  final int statusCode;
  final SearchRequestStatus roomsSearchRequestStatus;
  final SearchRequestStatus podcastSearchRequestStatus;
  final SearchRequestStatus usersSearchRequestStatus;
  final SearchRequestStatus allPodcastsRequestStatus;

  final SearchRequestStatus allPodcastsGetMorreRequestStatus;
  final List<SearchRoomsEntity> roomsSearchEntitie;
  final List<SearchUsersEntity> usersSearchEntitie;
  final PodcastSearchEntity podcastSearchEntitie;
  final PodcastSearchEntity allPodcastsEntitie;
  final bool isEndOfAllPodcasts;
  const SearchState({
    this.errorMessages = '',
    this.statusCode = 0,
    this.allPodcastsGetMorreRequestStatus = SearchRequestStatus.idle,
    this.allPodcastsEntitie =
        const PodcastSearchEntity(results: 0, podcastInformationEntitie: []),
    this.roomsSearchRequestStatus = SearchRequestStatus.idle,
    this.allPodcastsRequestStatus = SearchRequestStatus.idle,
    this.podcastSearchRequestStatus = SearchRequestStatus.idle,
    this.usersSearchRequestStatus = SearchRequestStatus.idle,
    this.roomsSearchEntitie = const [],
    this.usersSearchEntitie = const [],
    this.isEndOfAllPodcasts = false,
    this.podcastSearchEntitie =
        const PodcastSearchEntity(results: 0, podcastInformationEntitie: []),
  });

  SearchState copyWith({
    SearchRequestStatus? allPodcastsGetMorreRequestStatus,
    bool? isEndOfAllPodcasts,
    SearchRequestStatus? allPodcastsRequestStatus,
    PodcastSearchEntity? allPodcastsEntitie,
    String? errorMessages,
    int? statusCode,
    SearchRequestStatus? roomsSearchRequestStatus,
    SearchRequestStatus? podcastSearchRequestStatus,
    SearchRequestStatus? usersSearchRequestStatus,
    List<SearchRoomsEntity>? roomsSearchEntitie,
    List<SearchUsersEntity>? usersSearchEntitie,
    PodcastSearchEntity? podcastSearchEntitie,
  }) {
    return SearchState(
      allPodcastsGetMorreRequestStatus: allPodcastsGetMorreRequestStatus ??
          this.allPodcastsGetMorreRequestStatus,
      isEndOfAllPodcasts: isEndOfAllPodcasts ?? this.isEndOfAllPodcasts,
      allPodcastsRequestStatus:
          allPodcastsRequestStatus ?? this.allPodcastsRequestStatus,
      allPodcastsEntitie: allPodcastsEntitie ?? this.allPodcastsEntitie,
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
        allPodcastsGetMorreRequestStatus,
        isEndOfAllPodcasts,
        allPodcastsRequestStatus,
        allPodcastsEntitie,
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
