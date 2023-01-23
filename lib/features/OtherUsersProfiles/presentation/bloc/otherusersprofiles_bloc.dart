import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_event.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_users_data_entitie.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/follow_user.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/get_other_user_podcasts.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/other_user_events.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utl/utls.dart';
import '../../domain/entities/followers_following_data_entitie.dart';
import '../../domain/usecases/get_user_followers.dart';
import '../../domain/usecases/get_user_following.dart';
import '../../domain/usecases/get_user_profile_data.dart';
import '../../domain/usecases/un_follow_user.dart';

part 'otherusersprofiles_event.dart';
part 'otherusersprofiles_state.dart';

class OtherUserProfileBloc
    extends Bloc<OtherUserProfileEvent, OtherUserProfileState> {
  OtherUserProfileBloc(
      this.otherUserProfileDataGetUsecase,
      this.otherUserFollowersUsecase,
      this.otherUserFollowingUsecase,
      this.followUserUsecase,
      this.unFollowUserUsecase,
      this.otherUserEventsUsecase,
      this.otherUserPodcastUsecase)
      : super(const OtherUserProfileState()) {
    on<OtherUserProfileGetEvent>(_getuserProfileData);
    on<OtherUserFollowersGetEvent>(_getUserFollowersData);
    on<OtherUserFollowingGetEvent>(_getUserFollowingData);
    on<OtherUserFollowersGetMoreEvent>(_getUserFollowersMoreData);
    on<OtherUserFollowingGetMoreEvent>(_getUserFollowingMoreData);
    on<OtherUserPodcastsGetEvent>(_getOtherUserPodcastsData);
    on<OtherUserPodcastsGetMoreEvent>(_getOtherUserPodcastsMoreData);
    on<FollowUserEvent>(_followUser);
    on<UnFollowUserEvent>(_unFollowUser);
    on<OtherUserEventsGetEvent>(_getOtherUserEvents);
    on<OtherUserEventsGetMoreEvent>(_getOtherUserEventsMore);
  }
  final OtherUserProfileDataGetUsecase otherUserProfileDataGetUsecase;
  final OtherUserFollowingUsecase otherUserFollowingUsecase;
  final OtherUserFollowersUsecase otherUserFollowersUsecase;
  final OtherUserPodcastUsecase otherUserPodcastUsecase;
  final OtherUserFollowUsecase followUserUsecase;
  final OtherUserUnFollowUsecase unFollowUserUsecase;
  final OtherUserEventsUsecase otherUserEventsUsecase;
  FutureOr<void> _getuserProfileData(OtherUserProfileGetEvent event,
      Emitter<OtherUserProfileState> emit) async {
    if (state.userDataGetRequestStatus != UserDataGetRequestStatus.loading) {
      emit(state.copyWith(
          userDataGetRequestStatus: UserDataGetRequestStatus.loading));
    }

    final result = await otherUserProfileDataGetUsecase(
        UserProfileDataGetParams(
            accessToken: event.accessToken, userId: event.userId));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            userDataGetRequestStatus: UserDataGetRequestStatus.error)), (r) {
      emit(
        state.copyWith(
          isFollowed: r.isFollowing,
          errorMessage: '',
          statusCode: 0,
          userDataGetRequestStatus: UserDataGetRequestStatus.success,
          otherUserDataEntitie: r,
        ),
      );
      if (r.isFollowing) {
        add(OtherUserEventsGetEvent(
            accessToken: event.accessToken, userId: r.uid));
      }
    });
  }

  FutureOr<void> _getUserFollowersData(OtherUserFollowersGetEvent event,
      Emitter<OtherUserProfileState> emit) async {
    if (state.followersFollowingDataGetRequestStatus !=
        FollowersFollowingDataGetRequestStatus.loading) {
      emit(state.copyWith(
          followersFollowingDataGetRequestStatus:
              FollowersFollowingDataGetRequestStatus.loading));
    }
    final result = await otherUserFollowersUsecase(
        OtherUserFollowersFollowingParams(
            accessToken: event.accessToken, uid: event.userId, page: 1));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            followersFollowingDataGetRequestStatus:
                FollowersFollowingDataGetRequestStatus.error)), (r) {
      if (r.results <= 10) {
        emit(
          state.copyWith(
            errorMessage: '',
            statusCode: 0,
            isEndOfFollowersData: true,
            followersFollowingDataGetRequestStatus:
                FollowersFollowingDataGetRequestStatus.success,
            otherUserFollowersFollowingDataEntitie: r,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: '',
            statusCode: 0,
            isEndOfFollowersData: false,
            followersFollowingDataGetRequestStatus:
                FollowersFollowingDataGetRequestStatus.success,
            otherUserFollowersFollowingDataEntitie: r,
          ),
        );
      }
    });
  }

  FutureOr<void> _getUserFollowingData(OtherUserFollowingGetEvent event,
      Emitter<OtherUserProfileState> emit) async {
    if (state.followersFollowingDataGetRequestStatus !=
        FollowersFollowingDataGetRequestStatus.loading) {
      emit(state.copyWith(
          followersFollowingDataGetRequestStatus:
              FollowersFollowingDataGetRequestStatus.loading));
    }
    final result = await otherUserFollowingUsecase(
        OtherUserFollowersFollowingParams(
            accessToken: event.accessToken, uid: event.userId, page: 1));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            followersFollowingDataGetRequestStatus:
                FollowersFollowingDataGetRequestStatus.error)), (r) {
      if (r.results <= 10) {
        emit(
          state.copyWith(
            errorMessage: '',
            statusCode: 0,
            isEndOfFollowingData: true,
            followersFollowingDataGetRequestStatus:
                FollowersFollowingDataGetRequestStatus.success,
            otherUserFollowersFollowingDataEntitie: r,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: '',
            statusCode: 0,
            isEndOfFollowingData: false,
            followersFollowingDataGetRequestStatus:
                FollowersFollowingDataGetRequestStatus.success,
            otherUserFollowersFollowingDataEntitie: r,
          ),
        );
      }
    });
  }

  FutureOr<void> _getUserFollowersMoreData(OtherUserFollowersGetMoreEvent event,
      Emitter<OtherUserProfileState> emit) async {
    final result = await otherUserFollowersUsecase(
        OtherUserFollowersFollowingParams(
            accessToken: event.accessToken,
            uid: event.userId,
            page: event.page));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            isEndOfFollowersData: true)), (r) {
      if (r.results == 0) {
        emit(state.copyWith(
          isEndOfFollowersData: true,
        ));
      } else if (r.results == 10) {
        OtherUserFollowersFollowingDataEntitie
            otherUserFollowersFollowingDataEntitie;
        otherUserFollowersFollowingDataEntitie =
            state.otherUserFollowersFollowingDataEntitie!;

        otherUserFollowersFollowingDataEntitie
            .otherUserFollowersFollowingUserDataEntitie
            .addAll(r.otherUserFollowersFollowingUserDataEntitie);

        emit(state.copyWith(
          errorMessage: '',
          statusCode: 0,
          otherUserFollowersFollowingDataEntitie:
              otherUserFollowersFollowingDataEntitie,
          isEndOfFollowersData: false,
        ));
      } else {
        OtherUserFollowersFollowingDataEntitie
            otherUserFollowersFollowingDataEntitie =
            state.otherUserFollowersFollowingDataEntitie!;
        otherUserFollowersFollowingDataEntitie
            .otherUserFollowersFollowingUserDataEntitie
            .addAll(r.otherUserFollowersFollowingUserDataEntitie);
        emit(state.copyWith(
          errorMessage: '',
          otherUserFollowersFollowingDataEntitie:
              otherUserFollowersFollowingDataEntitie,
          isEndOfFollowersData: true,
        ));
      }
    });
  }

  FutureOr<void> _getUserFollowingMoreData(OtherUserFollowingGetMoreEvent event,
      Emitter<OtherUserProfileState> emit) async {
    final result = await otherUserFollowingUsecase(
        OtherUserFollowersFollowingParams(
            accessToken: event.accessToken,
            uid: event.userId,
            page: event.page));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            isEndOfFollowingData: true)), (r) {
      if (r.results == 0) {
        emit(state.copyWith(
          isEndOfFollowingData: true,
        ));
      } else if (r.results == 10) {
        OtherUserFollowersFollowingDataEntitie
            otherUserFollowersFollowingDataEntitie;
        otherUserFollowersFollowingDataEntitie =
            state.otherUserFollowersFollowingDataEntitie!;

        otherUserFollowersFollowingDataEntitie
            .otherUserFollowersFollowingUserDataEntitie
            .addAll(r.otherUserFollowersFollowingUserDataEntitie);

        emit(state.copyWith(
          errorMessage: '',
          statusCode: 0,
          otherUserFollowersFollowingDataEntitie:
              otherUserFollowersFollowingDataEntitie,
          isEndOfFollowingData: false,
        ));
      } else {
        OtherUserFollowersFollowingDataEntitie
            otherUserFollowersFollowingDataEntitie =
            state.otherUserFollowersFollowingDataEntitie!;
        otherUserFollowersFollowingDataEntitie
            .otherUserFollowersFollowingUserDataEntitie
            .addAll(r.otherUserFollowersFollowingUserDataEntitie);
        emit(state.copyWith(
          errorMessage: '',
          otherUserFollowersFollowingDataEntitie:
              otherUserFollowersFollowingDataEntitie,
          isEndOfFollowingData: true,
        ));
      }
    });
  }

  FutureOr<void> _getOtherUserPodcastsData(OtherUserPodcastsGetEvent event,
      Emitter<OtherUserProfileState> emit) async {
    if (state.otherUserPodcastGetRequestStatus !=
        UserDataGetRequestStatus.loading) {
      emit(state.copyWith(
          otherUserPodcastGetRequestStatus: UserDataGetRequestStatus.loading));
    }
    final result = await otherUserPodcastUsecase(OtherUserPodcastParams(
        accessToken: event.accessToken, userId: event.userId, page: 1));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            otherUserPodcastGetRequestStatus: UserDataGetRequestStatus.error)),
        (r) {
      if (r.results <= 10) {
        emit(
          state.copyWith(
            errorMessage: '',
            statusCode: 0,
            isEndOfPodcastData: true,
            otherUserPodcastGetRequestStatus: UserDataGetRequestStatus.success,
            otherUserPodcastEntitie: r,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: '',
            statusCode: 0,
            isEndOfPodcastData: false,
            otherUserPodcastGetRequestStatus: UserDataGetRequestStatus.success,
            otherUserPodcastEntitie: r,
          ),
        );
      }
    });
  }

  FutureOr<void> _getOtherUserPodcastsMoreData(
      OtherUserPodcastsGetMoreEvent event,
      Emitter<OtherUserProfileState> emit) async {
    final result = await otherUserPodcastUsecase(OtherUserPodcastParams(
        accessToken: event.accessToken,
        userId: event.userId,
        page: event.page));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            isEndOfPodcastData: true)), (r) {
      if (r.results == 0) {
        emit(state.copyWith(
          isEndOfPodcastData: true,
        ));
      } else if (r.results == 10) {
        OtherUserPodcastEntitie otherUserPodcastEntitie;
        otherUserPodcastEntitie = state.otherUserPodcastEntitie!;

        otherUserPodcastEntitie.otherUserPodcastDataEntitie
            .addAll(r.otherUserPodcastDataEntitie);

        emit(state.copyWith(
          errorMessage: '',
          statusCode: 0,
          otherUserPodcastEntitie: otherUserPodcastEntitie,
          isEndOfPodcastData: false,
        ));
      } else {
        OtherUserPodcastEntitie otherUserPodcastEntitie =
            state.otherUserPodcastEntitie!;
        otherUserPodcastEntitie.otherUserPodcastDataEntitie
            .addAll(r.otherUserPodcastDataEntitie);
        emit(state.copyWith(
          errorMessage: '',
          otherUserPodcastEntitie: otherUserPodcastEntitie,
          isEndOfPodcastData: true,
        ));
      }
    });
  }

  FutureOr<void> _followUser(
      FollowUserEvent event, Emitter<OtherUserProfileState> emit) async {
    if (state.followUnfollowUserRequestStatus !=
        FollowUnfollowUserRequestStatus.loading) {
      emit(state.copyWith(
          followUnfollowUserRequestStatus:
              FollowUnfollowUserRequestStatus.loading));
    }
    final result = await followUserUsecase(FollowUnfollowUserParams(
        accessToken: event.accessToken, userId: event.userId));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            followUnfollowUserRequestStatus:
                FollowUnfollowUserRequestStatus.error)), (r) {
      emit(state.copyWith(
          isFollowed: true,
          errorMessage: '',
          statusCode: 0,
          followUnfollowUserRequestStatus:
              FollowUnfollowUserRequestStatus.success));

      add(OtherUserEventsGetEvent(
          accessToken: event.accessToken, userId: event.userId));
    });
  }

  FutureOr<void> _unFollowUser(
      UnFollowUserEvent event, Emitter<OtherUserProfileState> emit) async {
    if (state.followUnfollowUserRequestStatus !=
        FollowUnfollowUserRequestStatus.loading) {
      emit(state.copyWith(
          followUnfollowUserRequestStatus:
              FollowUnfollowUserRequestStatus.loading));
    }
    final result = await unFollowUserUsecase(FollowUnfollowUserParams(
        accessToken: event.accessToken, userId: event.userId));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            followUnfollowUserRequestStatus:
                FollowUnfollowUserRequestStatus.error)), (r) {
      emit(state.copyWith(
          isFollowed: false,
          errorMessage: '',
          statusCode: 0,
          followUnfollowUserRequestStatus:
              FollowUnfollowUserRequestStatus.success));
    });
  }

  FutureOr<void> _getOtherUserEvents(OtherUserEventsGetEvent event,
      Emitter<OtherUserProfileState> emit) async {
    if (state.otherUserEventsGetRequestStatus !=
        UserDataGetRequestStatus.loading) {
      emit(state.copyWith(
          otherUserEventsGetRequestStatus: UserDataGetRequestStatus.loading));
    }

    final result = await otherUserEventsUsecase(OtherUserEventsParams(
        accessToken: event.accessToken, userId: event.userId, page: 1));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            otherUserEventsGetRequestStatus: UserDataGetRequestStatus.error)),
        (r) {
      if (r.results <= 10) {
        emit(
          state.copyWith(
            errorMessage: '',
            statusCode: 0,
            isEndOfEventsData: true,
            otherUserEventsGetRequestStatus: UserDataGetRequestStatus.success,
            otherUserEventsEntitie: r,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: '',
            statusCode: 0,
            isEndOfEventsData: false,
            otherUserEventsGetRequestStatus: UserDataGetRequestStatus.success,
            otherUserEventsEntitie: r,
          ),
        );
      }
    });
  }

  FutureOr<void> _getOtherUserEventsMore(OtherUserEventsGetMoreEvent event,
      Emitter<OtherUserProfileState> emit) async {
    final result = await otherUserEventsUsecase(OtherUserEventsParams(
        accessToken: event.accessToken,
        userId: event.userId,
        page: event.page));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            isEndOfEventsData: true)), (r) {
      if (r.results == 0) {
        emit(state.copyWith(
          isEndOfEventsData: true,
        ));
      } else if (r.results == 10) {
        OtherUserEventsEntitie otherUserEventsEntitie;
        otherUserEventsEntitie = state.otherUserEventsEntitie!;

        otherUserEventsEntitie.events.addAll(r.events);

        emit(state.copyWith(
          errorMessage: '',
          statusCode: 0,
          otherUserEventsEntitie: otherUserEventsEntitie,
          isEndOfEventsData: false,
        ));
      } else {
        OtherUserEventsEntitie otherUserEventsEntitie =
            state.otherUserEventsEntitie!;
        otherUserEventsEntitie.events.addAll(r.events);
        emit(state.copyWith(
          errorMessage: '',
          otherUserEventsEntitie: otherUserEventsEntitie,
          isEndOfEventsData: true,
        ));
      }
    });
  }
}
