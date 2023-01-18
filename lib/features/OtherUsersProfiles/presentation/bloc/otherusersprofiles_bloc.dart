import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_users_data_entitie.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utl/utls.dart';
import '../../domain/usecases/get_user_profile_data.dart';

part 'otherusersprofiles_event.dart';
part 'otherusersprofiles_state.dart';

class OtherUserProfileBloc
    extends Bloc<OtherUserProfileEvent, OtherUserProfileState> {
  OtherUserProfileBloc(this.otherUserProfileDataGetUsecase)
      : super(const OtherUserProfileState()) {
    on<OtherUserProfileGetEvent>(_getuserProfileData);
  }
  final OtherUserProfileDataGetUsecase otherUserProfileDataGetUsecase;
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
}
