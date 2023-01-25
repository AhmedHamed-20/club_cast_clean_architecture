import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/category_entitie.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/my_following_events_entitie.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/user_data_entitie.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_active_user_data.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_cached_access_token.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_categories.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_my_following_events.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/remove_access_token.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/presentation/screens/my_following_podcast_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../features/Rooms/presentation/screens/all_rooms_screen.dart';
import '../../../constants/base_user_info_entitie/base_user_info_entite.dart';
import '../../../utl/utls.dart';
import '../../domain/usecases/update_cached_access_token.dart';

part 'layout_event.dart';
part 'layout_state.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  LayoutBloc(
      this.activeUserDataGetUseCase,
      this.cachedAccessTokenGetUsecase,
      this.myFollowingEventsUsecase,
      this.categoriesGetUsecase,
      this.accessTokenRemoveUsecase,
      this.cachedAccessTokenUpdateUsecase)
      : super(const LayoutState()) {
    on<ActiveUserDataGetEvent>(_getActiveUserData);
    on<AccessTokenGetFromCacheEvent>(_getAccessTokenFromCache);
    on<MyFollowingEventsGetEvent>(_getMyFollowingEvents);
    on<MyFollowingEventsGetMoreEvent>(_myFollowingEventGetMore);
    on<BottomNavIndexChangeEvent>(_changeBottomNavIndex);
    on<CategoriesGetEvent>(_getCategories);
    on<CachedAccessTokenUpdateEvent>(_updateCachedAccessToken);
    on<AccessTokenRemoveEvent>(_removeAccessToken);
  }
  final ActiveUserDataGetUseCase activeUserDataGetUseCase;
  final CachedAccessTokenGetUsecase cachedAccessTokenGetUsecase;
  final MyFollowingEventsUsecase myFollowingEventsUsecase;
  final CategoriesGetUsecase categoriesGetUsecase;
  final CachedAccessTokenUpdateUsecase cachedAccessTokenUpdateUsecase;
  final AccessTokenRemoveUsecase accessTokenRemoveUsecase;
  final List<Widget> bottomNaveIcons = const [
    NavigationDestination(
      icon: Icon(Icons.home),
      label: 'home',
    ),
    NavigationDestination(
      icon: Icon(Icons.add),
      label: '',
    ),
    NavigationDestination(
      icon: Icon(Icons.headphones),
      label: 'podCast',
    ),
  ];

  final appBarTitles = ['Home', '', 'Podcasts'];

  final List<Widget> bottomNaveScreens = [
    const AllRoomsScreen(),
    Container(),
    const MyFollowingPodcastScreen(),
  ];
  FutureOr<void> _getActiveUserData(
      ActiveUserDataGetEvent event, Emitter<LayoutState> emit) async {
    if (state.userDataGetRequestStatus == UserDataGetRequestStatus.error) {
      emit(state.copyWith(
          userDataGetRequestStatus: UserDataGetRequestStatus.loading));
    }
    final result = await activeUserDataGetUseCase(
        ActiveUserDataGetParams(event.accessToken));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            userDataGetRequestStatus: UserDataGetRequestStatus.error,
            statusCode: l.statusCode)), (r) {
      emit(
        state.copyWith(
          errorMessage: '',
          userDataEntitie: r,
          userDataGetRequestStatus: UserDataGetRequestStatus.success,
        ),
      );
    });
  }

  FutureOr<void> _getAccessTokenFromCache(
      AccessTokenGetFromCacheEvent event, Emitter<LayoutState> emit) async {
    final result = await cachedAccessTokenGetUsecase(
        CachedAccessTokenGetParams(event.key));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            getAccessTokenRequestStatus: UserDataGetRequestStatus.error,
            statusCode: l.statusCode)), (r) {
      emit(state.copyWith(
          errorMessage: '',
          getAccessTokenRequestStatus: UserDataGetRequestStatus.success));

      ConstVar.accessToken = r;
    });
  }

  FutureOr<void> _getMyFollowingEvents(
      MyFollowingEventsGetEvent event, Emitter<LayoutState> emit) async {
    final result = await myFollowingEventsUsecase(
        MyFollowingEventsParams(event.accessToken, 1));
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            isEndOfEvents: true,
            myFollowingEventsRequestStatus: UserDataGetRequestStatus.error,
            statusCode: l.statusCode)), (r) {
      if (r.results <= 10) {
        emit(
          state.copyWith(
            errorMessage: '',
            isEndOfEvents: true,
            myFollowingEventsEntitie: r,
            myFollowingEventsRequestStatus: UserDataGetRequestStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: '',
            isEndOfEvents: false,
            myFollowingEventsEntitie: r,
            myFollowingEventsRequestStatus: UserDataGetRequestStatus.success,
          ),
        );
      }
    });
  }

  FutureOr<void> _changeBottomNavIndex(
      BottomNavIndexChangeEvent event, Emitter<LayoutState> emit) {
    emit(state.copyWith(currentBottomNavIndex: event.index));
  }

  FutureOr<void> _getCategories(
      CategoriesGetEvent event, Emitter<LayoutState> emit) async {
    final result = await categoriesGetUsecase(NoParams());
    result.fold(
      (l) => emit(state.copyWith(
          errorMessage: l.message,
          statusCode: l.statusCode,
          categoriesRequestStatus: UserDataGetRequestStatus.error)),
      (r) => emit(
        state.copyWith(
          errorMessage: '',
          statusCode: 0,
          categoryEntitie: r,
          categoriesRequestStatus: UserDataGetRequestStatus.success,
        ),
      ),
    );
  }

  FutureOr<void> _updateCachedAccessToken(
      CachedAccessTokenUpdateEvent event, Emitter<LayoutState> emit) async {
    emit(state.copyWith(
        accessTokenUpdateRequestStatus:
            AccessTokenUpdateRequestStatus.loading));
    final result = await cachedAccessTokenUpdateUsecase(
        CachedAccessTokenUpdateParams(key: event.key, value: event.value));

    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
              accessTokenUpdateRequestStatus:
                  AccessTokenUpdateRequestStatus.error,
            )), (r) {
      ConstVar.accessToken = event.value;
      emit(state.copyWith(
          errorMessage: '',
          accessTokenUpdateRequestStatus:
              AccessTokenUpdateRequestStatus.success));
    });
  }

  FutureOr<void> _removeAccessToken(
      AccessTokenRemoveEvent event, Emitter<LayoutState> emit) async {
    emit(state.copyWith(logoutRequestStatus: LogoutRequestStatus.loading));

    final result = await accessTokenRemoveUsecase(AccessTokenRemoveParams(
      key: event.key,
    ));
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            logoutRequestStatus: LogoutRequestStatus.error)), (r) {
      ConstVar.accessToken = '';
      emit(state.copyWith(
          errorMessage: '',
          userDataGetRequestStatus: UserDataGetRequestStatus.loading,
          logoutRequestStatus: LogoutRequestStatus.logoutSuccess));
    });
  }

  FutureOr<void> _myFollowingEventGetMore(
      MyFollowingEventsGetMoreEvent event, Emitter<LayoutState> emit) async {
    final result = await myFollowingEventsUsecase(
        MyFollowingEventsParams(event.accessToken, event.page));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            myFollowingEventsRequestStatus: UserDataGetRequestStatus.error,
            statusCode: l.statusCode)), (r) {
      if (r.results == 0) {
        emit(state.copyWith(
          isEndOfEvents: true,
        ));
      } else if (r.results == 10) {
        MyFollowingEventsEntitie myFollowingEventsEntitie;
        myFollowingEventsEntitie = state.myFollowingEventsEntitie!;

        myFollowingEventsEntitie.myFollowingEventsDataEntitie
            .addAll(r.myFollowingEventsDataEntitie);

        emit(state.copyWith(
          errorMessage: '',
          statusCode: 0,
          myFollowingEventsEntitie: myFollowingEventsEntitie,
          isEndOfEvents: false,
        ));
      } else {
        MyFollowingEventsEntitie myFollowingEventsEntitie =
            state.myFollowingEventsEntitie!;
        myFollowingEventsEntitie.myFollowingEventsDataEntitie
            .addAll(r.myFollowingEventsDataEntitie);
        emit(state.copyWith(
          errorMessage: '',
          myFollowingEventsEntitie: myFollowingEventsEntitie,
          isEndOfEvents: true,
        ));
      }
    });
  }
}
