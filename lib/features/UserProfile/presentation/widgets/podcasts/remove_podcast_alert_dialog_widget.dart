import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utl/utls.dart';

class RemovePodcastAlertDialogWidget extends StatelessWidget {
  const RemovePodcastAlertDialogWidget({
    Key? key,
    required this.podcastId,
    required this.podcastName,
  }) : super(key: key);
  final String podcastName;
  final String podcastId;
  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    return BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
      if (state.myPodCastRemoveRequestStatus ==
          MyDataRemoveRequestStatus.removed) {
        flutterToast(
            msg: 'Podcast Removed',
            backgroundColor: AppColors.toastSuccess,
            textColor: AppColors.white);
        Navigator.of(context).pop();
      } else if (state.myPodCastRemoveRequestStatus ==
          MyDataRemoveRequestStatus.error) {
        flutterToast(
            msg: state.errorMessage,
            backgroundColor: AppColors.toastError,
            textColor: AppColors.white);
        Navigator.of(context).pop();
      }
    }, builder: (context, state) {
      switch (state.myPodCastRemoveRequestStatus) {
        case MyDataRemoveRequestStatus.idle:
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.background,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12)),
            title: Text(
              'Are You Sure ?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Text(
              'Remove this $podcastName podcast',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'No',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      userProfileBloc.add(PodcastRemoveEvent(
                          accessToken: ConstVar.accessToken,
                          podcastId: podcastId));
                    },
                    child: Text(
                      'Yes',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              )
            ],
          );
        case MyDataRemoveRequestStatus.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case MyDataRemoveRequestStatus.removed:
          return const SizedBox.shrink();
        case MyDataRemoveRequestStatus.error:
          return const SizedBox.shrink();
      }
    });
  }
}
