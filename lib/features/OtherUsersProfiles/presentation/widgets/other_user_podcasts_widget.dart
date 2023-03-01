import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utl/utls.dart';
import '../../../../core/widgets/error_screen.dart';
import 'main_other_user_podcast_widget.dart';

class OtherUserPodcastsWidget extends StatelessWidget {
  const OtherUserPodcastsWidget({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtherUserProfileBloc, OtherUserProfileState>(
      listener: (context, state) {
        isEndOfOtherUserPodcastData = state.isEndOfPodcastData;
      },
      builder: (context, state) {
        switch (state.otherUserPodcastGetRequestStatus) {
          case UserDataGetRequestStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case UserDataGetRequestStatus.success:
            if (state
                .otherUserPodcastEntitie!.otherUserPodcastDataEntitie.isEmpty) {
              return Center(
                child: Text(
                  'No Podcasts Found',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            } else {
              return Column(
                children: [
                  Text(
                    'User Podcasts ${state.otherUserPodcastEntitie!.otherUserPodcastDataEntitie.length}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: AppHeight.h10,
                  ),
                  Expanded(
                    child: MainOtherUserPodcastWidget(
                      otherUserPodcastEntitie: state.otherUserPodcastEntitie!,
                      userId: state.otherUserDataEntitie!.uid,
                    ),
                  ),
                ],
              );
            }
          case UserDataGetRequestStatus.error:
            if (state.statusCode == 403 || state.statusCode == 401) {
              return ErrorScreen(
                isHoleScreen: false,
                message: state.errorMessage,
                statusCode: state.statusCode,
              );
            } else {
              return ErrorScreen(
                isHoleScreen: false,
                message: state.errorMessage,
                onRetry: () {
                  BlocProvider.of<OtherUserProfileBloc>(context).add(
                    OtherUserPodcastsGetEvent(
                      accessToken: ConstVar.accessToken,
                      userId: userId,
                    ),
                  );
                },
              );
            }
        }
      },
    );
  }
}
