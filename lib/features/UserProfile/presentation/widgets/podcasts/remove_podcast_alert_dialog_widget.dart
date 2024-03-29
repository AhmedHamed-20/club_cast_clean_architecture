import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/MyPodcastBloc/my_podcast_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
    final myPodcastBloc = BlocProvider.of<MyPodcastBloc>(context);
    return BlocConsumer<MyPodcastBloc, MyPodcastState>(
        listener: (context, state) {
      if (state.myPodCastRemoveRequestStatus ==
          MyDataRemoveRequestStatus.removed) {
        flutterToast(
            msg: AppStrings.podcastRemoved.tr(),
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
              AppStrings.areYouSure.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Text(
              '${AppStrings.removeThis.tr()} $podcastName ${AppStrings.podcast.tr()}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppStrings.no.tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              TextButton(
                onPressed: () {
                  myPodcastBloc.add(PodcastRemoveEvent(
                      accessToken: ConstVar.accessToken, podcastId: podcastId));
                },
                child: Text(
                  AppStrings.yes.tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
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
