import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/podcast_search_entitie.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/all_podcasts.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/podcast_search.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utl/utls.dart';
import '../../domain/entities/search_rooms_entitie.dart';
import '../../domain/entities/search_users_info_entite.dart';
import '../../domain/usecases/rooms_search.dart';
import '../../domain/usecases/users_search.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.podcastSearchUsecase, this.roomsSearchUsecase,
      this.usersSearchUsecase, this.allPodcastsUsecase)
      : super(const SearchState()) {
    on<PodcastSearchEvent>(_podcastSearchEvent);
    on<RoomsSearchEvent>(_roomsSearchEvent);
    on<UsersSearchEvent>(_usersSearchEvent);
    on<AllPodcastEvent>(_getAllPodcastEvent);
    on<AllPodcastGetMoreEvent>(_allPodcastGetMoreEvent);
  }
  final PodcastSearchUsecase podcastSearchUsecase;
  final RoomsSearchUsecase roomsSearchUsecase;
  final UsersSearchUsecase usersSearchUsecase;
  final AllPodcastsUsecase allPodcastsUsecase;
  FutureOr<void> _podcastSearchEvent(
      PodcastSearchEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(
        podcastSearchRequestStatus: SearchRequestStatus.loading));
    final result = await podcastSearchUsecase(
        SearchParams(query: event.query, accessToken: event.accessToken));
    result.fold((l) {
      emit(state.copyWith(
          podcastSearchRequestStatus: SearchRequestStatus.error,
          errorMessages: l.message,
          statusCode: l.statusCode));
    }, (r) {
      emit(
        state.copyWith(
          podcastSearchRequestStatus: SearchRequestStatus.success,
          podcastSearchEntitie: r,
        ),
      );
    });
  }

  FutureOr<void> _roomsSearchEvent(
      RoomsSearchEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(roomsSearchRequestStatus: SearchRequestStatus.loading));
    final result = await roomsSearchUsecase(
        SearchParams(query: event.query, accessToken: event.accessToken));
    result.fold((l) {
      emit(state.copyWith(
          roomsSearchRequestStatus: SearchRequestStatus.error,
          errorMessages: l.message,
          statusCode: l.statusCode));
    }, (r) {
      emit(
        state.copyWith(
          roomsSearchRequestStatus: SearchRequestStatus.success,
          roomsSearchEntitie: r,
        ),
      );
    });
  }

  FutureOr<void> _usersSearchEvent(
      UsersSearchEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(usersSearchRequestStatus: SearchRequestStatus.loading));
    final result = await usersSearchUsecase(
        SearchParams(query: event.query, accessToken: event.accessToken));
    result.fold((l) {
      emit(state.copyWith(
          usersSearchRequestStatus: SearchRequestStatus.error,
          errorMessages: l.message,
          statusCode: l.statusCode));
    }, (r) {
      emit(
        state.copyWith(
          usersSearchRequestStatus: SearchRequestStatus.success,
          usersSearchEntitie: r,
        ),
      );
    });
  }

  FutureOr<void> _getAllPodcastEvent(
      AllPodcastEvent event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        allPodcastsRequestStatus: SearchRequestStatus.loading,
      ),
    );
    final result = await allPodcastsUsecase(
      AllPodcastsParams(
        accessToken: event.accessToken,
        page: event.page,
      ),
    );
    result.fold((l) {
      emit(
        state.copyWith(
          allPodcastsRequestStatus: SearchRequestStatus.error,
          errorMessages: l.message,
          statusCode: l.statusCode,
          isEndOfAllPodcasts: true,
        ),
      );
    }, (r) {
      if (r.results < 10) {
        emit(
          state.copyWith(
            allPodcastsRequestStatus: SearchRequestStatus.success,
            allPodcastsEntitie: r,
            isEndOfAllPodcasts: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            allPodcastsRequestStatus: SearchRequestStatus.success,
            allPodcastsEntitie: r,
            isEndOfAllPodcasts: false,
          ),
        );
      }
    });
  }

  FutureOr<void> _allPodcastGetMoreEvent(
      AllPodcastGetMoreEvent event, Emitter<SearchState> emit) async {
    final result = await allPodcastsUsecase(
      AllPodcastsParams(
        accessToken: event.accessToken,
        page: event.page,
      ),
    );
    result.fold((l) {
      emit(
        state.copyWith(
          allPodcastsRequestStatus: SearchRequestStatus.error,
          errorMessages: l.message,
          statusCode: l.statusCode,
          isEndOfAllPodcasts: true,
        ),
      );
    }, (r) {
      if (r.results == 0) {
        emit(state.copyWith(
            isEndOfAllPodcasts: true,
            allPodcastsGetMorreRequestStatus: SearchRequestStatus.success));
      } else if (r.results == 10) {
        PodcastSearchEntitie allPodcasts;
        allPodcasts = state.allPodcastsEntitie;

        allPodcasts.podcastInformationEntitie
            .addAll(r.podcastInformationEntitie);

        emit(state.copyWith(
          errorMessages: '',
          statusCode: 0,
          allPodcastsEntitie: allPodcasts,
          isEndOfAllPodcasts: false,
          allPodcastsGetMorreRequestStatus: SearchRequestStatus.success,
        ));
      } else {
        PodcastSearchEntitie allPodcasts = state.allPodcastsEntitie;
        allPodcasts.podcastInformationEntitie
            .addAll(r.podcastInformationEntitie);
        emit(state.copyWith(
          errorMessages: '',
          allPodcastsEntitie: allPodcasts,
          isEndOfAllPodcasts: true,
          allPodcastsGetMorreRequestStatus: SearchRequestStatus.success,
        ));
      }
    });
  }
}
