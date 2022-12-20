import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/my_following_events_entitie.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/user_data_entitie.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_active_user_data.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_cached_access_token.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_my_following_events.dart';
import 'package:equatable/equatable.dart';

import '../../../utl/utls.dart';

part 'layout_event.dart';
part 'layout_state.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  LayoutBloc(this.activeUserDataGetUseCase, this.cachedAccessTokenGetUsecase,
      this.myFollowingEventsUsecase)
      : super(const LayoutState()) {
    on<ActiveUserDataGetEvent>(_getActiveUserData);
    on<AccessTokenGetFromCacheEvent>(_getAccessTokenFromCache);
    on<MyFollowingEventsGetEvent>(_getMyFollowingEvents);
  }
  final ActiveUserDataGetUseCase activeUserDataGetUseCase;
  final CachedAccessTokenGetUsecase cachedAccessTokenGetUsecase;
  final MyFollowingEventsUsecase myFollowingEventsUsecase;
  FutureOr<void> _getActiveUserData(
      ActiveUserDataGetEvent event, Emitter<LayoutState> emit) async {
    final result = await activeUserDataGetUseCase(
        ActiveUserDataGetParams(event.accessToken));

    result.fold(
      (l) => emit(state.copyWith(
          errorMessage: l.message,
          userDataGetRequestStatus: UserDataGetRequestStatus.error)),
      (r) => emit(
        state.copyWith(
          errorMessage: '',
          userDataEntitie: r,
          userDataGetRequestStatus: UserDataGetRequestStatus.success,
        ),
      ),
    );
  }

  FutureOr<void> _getAccessTokenFromCache(
      AccessTokenGetFromCacheEvent event, Emitter<LayoutState> emit) async {
    final result = await cachedAccessTokenGetUsecase(
        CachedAccessTokenGetParams(event.key));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            getAccessTokenRequestStatus: UserDataGetRequestStatus.error)), (r) {
      emit(state.copyWith(
          errorMessage: '',
          getAccessTokenRequestStatus: UserDataGetRequestStatus.success));

      ConstVar.accessToken = r;
    });
  }

  FutureOr<void> _getMyFollowingEvents(
      MyFollowingEventsGetEvent event, Emitter<LayoutState> emit) async {
    final result = await myFollowingEventsUsecase(
        MyFollowingEventsParams(event.accessToken));
    result.fold(
      (l) => emit(state.copyWith(
          errorMessage: l.message,
          myFollowingEventsRequestStatus: UserDataGetRequestStatus.error)),
      (r) => emit(
        state.copyWith(
          errorMessage: '',
          myFollowingEventsEntitie: r,
          myFollowingEventsRequestStatus: UserDataGetRequestStatus.success,
        ),
      ),
    );
  }
}
