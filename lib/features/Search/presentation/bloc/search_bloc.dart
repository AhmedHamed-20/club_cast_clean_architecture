import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/podcast_search_entitie.dart';
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
      this.usersSearchUsecase)
      : super(const SearchState()) {
    on<PodcastSearchEvent>(_podcastSearchEvent);
    on<RoomsSearchEvent>(_roomsSearchEvent);
    on<UsersSearchEvent>(_usersSearchEvent);
  }
  final PodcastSearchUsecase podcastSearchUsecase;
  final RoomsSearchUsecase roomsSearchUsecase;
  final UsersSearchUsecase usersSearchUsecase;
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
          roomsSearchRequestStatus: SearchRequestStatus.success,
          usersSearchEntitie: r,
        ),
      );
    });
  }
}
