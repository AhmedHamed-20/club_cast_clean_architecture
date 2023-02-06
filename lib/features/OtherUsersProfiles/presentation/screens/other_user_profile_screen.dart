import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/services/service_locator.dart';
import 'package:club_cast_clean_architecture/core/widgets/error_screen.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/params.dart';
import '../../../../core/utl/utls.dart';
import '../widgets/main_other_user_profile_widget.dart';

class OtherUserProfileScreen extends StatelessWidget {
  const OtherUserProfileScreen(
      {super.key, required this.otherUserProfileScreenParams});
  final OtherUserProfileScreenParams otherUserProfileScreenParams;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => servicelocator<OtherUserProfileBloc>()
        ..add(
          OtherUserProfileGetEvent(
            accessToken: ConstVar.accessToken,
            userId: otherUserProfileScreenParams.userId,
          ),
        )
        ..add(OtherUserPodcastsGetEvent(
            accessToken: ConstVar.accessToken,
            userId: otherUserProfileScreenParams.userId)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparentColor,
          iconTheme: Theme.of(context).iconTheme,
          centerTitle: true,
          title: Text(
            'User Profile Details',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: BlocBuilder<OtherUserProfileBloc, OtherUserProfileState>(
          builder: (context, state) {
            switch (state.userDataGetRequestStatus) {
              case UserDataGetRequestStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case UserDataGetRequestStatus.success:
                return MainOtherUserProfileWidget(
                  userId: otherUserProfileScreenParams.userId,
                );
              case UserDataGetRequestStatus.error:
                if (state.statusCode == 403 || state.statusCode == 401) {
                  return ErrorScreen(
                    message: state.errorMessage,
                    statusCode: state.statusCode,
                  );
                } else {
                  return ErrorScreen(
                    message: state.errorMessage,
                    onRetry: () {
                      BlocProvider.of<OtherUserProfileBloc>(context).add(
                          OtherUserProfileGetEvent(
                              accessToken: ConstVar.accessToken,
                              userId: otherUserProfileScreenParams.userId));
                    },
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
