import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';
import 'follow_unfollow_button_design.dart';

class FollowUnFollowButton extends StatelessWidget {
  const FollowUnFollowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtherUserProfileBloc, OtherUserProfileState>(
        listener: (context, state) {
      if (state.followersFollowingDataGetRequestStatus ==
          FollowUnfollowUserRequestStatus.error) {
        flutterToast(
            msg: state.errorMessage,
            backgroundColor: AppColors.toastError,
            textColor: AppColors.white);
      }
    }, builder: (context, state) {
      switch (state.followUnfollowUserRequestStatus) {
        case FollowUnfollowUserRequestStatus.loading:
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(AppPadding.p8),
              child: CircularProgressIndicator(),
            ),
          );
        case FollowUnfollowUserRequestStatus.success:
          return FollowUnfollowButtonDesign(
            state: state,
          );
        case FollowUnfollowUserRequestStatus.error:
          return FollowUnfollowButtonDesign(
            state: state,
          );
        case FollowUnfollowUserRequestStatus.idle:
          return FollowUnfollowButtonDesign(
            state: state,
          );
      }
    });
  }
}
