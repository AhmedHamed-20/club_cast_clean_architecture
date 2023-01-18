import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_users_data_entitie.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utl/utls.dart';
import '../../domain/entities/followers_following_data_entitie.dart';
import '../../domain/usecases/get_user_followers.dart';
import '../../domain/usecases/get_user_following.dart';
import '../../domain/usecases/get_user_profile_data.dart';

part 'otherusersprofiles_event.dart';
part 'otherusersprofiles_state.dart';

class OtherUserProfileBloc
    extends Bloc<OtherUserProfileEvent, OtherUserProfileState> {
  OtherUserProfileBloc(this.otherUserProfileDataGetUsecase,
      this.otherUserFollowersUsecase, this.otherUserFollowingUsecase)
      : super(const OtherUserProfileState()) {
    on<OtherUserProfileGetEvent>(_getuserProfileData);
    on<OtherUserFollowersGetEvent>(_getUserFollowersData);
    on<OtherUserFollowingGetEvent>(_getUserFollowingData);
  }
  final OtherUserProfileDataGetUsecase otherUserProfileDataGetUsecase;
  final OtherUserFollowingUsecase otherUserFollowingUsecase;
  final OtherUserFollowersUsecase otherUserFollowersUsecase;
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
          userDataGetRequestStatus: UserDataGetRequestStatus.error)),
      (r) => emit(
        state.copyWith(
          errorMessage: '',
          statusCode: 0,
          userDataGetRequestStatus: UserDataGetRequestStatus.success,
          otherUserDataEntitie: r,
        ),
      ),
    );
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
              FollowersFollowingDataGetRequestStatus.error)),
      (r) => emit(
        state.copyWith(
          errorMessage: '',
          statusCode: 0,
          followersFollowingDataGetRequestStatus:
              FollowersFollowingDataGetRequestStatus.success,
          otherUserFollowersFollowingDataEntitie: r,
        ),
      ),
    );
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
              FollowersFollowingDataGetRequestStatus.error)),
      (r) => emit(
        state.copyWith(
          errorMessage: '',
          statusCode: 0,
          followersFollowingDataGetRequestStatus:
              FollowersFollowingDataGetRequestStatus.success,
          otherUserFollowersFollowingDataEntitie: r,
        ),
      ),
    );
  }
}
