import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/MyPodcastBloc/my_podcast_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utl/utls.dart';
import '../../../../../core/widgets/defaults.dart';

class PickFileButton extends StatelessWidget {
  const PickFileButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myPodcastBloc = BlocProvider.of<MyPodcastBloc>(context);
    return BlocBuilder<MyPodcastBloc, MyPodcastState>(
        builder: (context, state) {
      switch (state.uploadPodcastRequestStatus) {
        case UploadPodcastRequestStatus.idle:
          return Defaults.defaultButton(
            onPressed: () {
              myPodcastBloc.add(const PickPodcastFileEvent());
            },
            context: context,
            text: state.pickedPodcastFilePath == ''
                ? AppStrings.pickAFile.tr()
                : AppStrings.changePickedFile.tr(),
          );
        case UploadPodcastRequestStatus.loading:
          return const SizedBox.shrink();
        case UploadPodcastRequestStatus.signatureGetSuccess:
          return const SizedBox.shrink();
        case UploadPodcastRequestStatus.podcastUploadedSuccess:
          return const SizedBox.shrink();
        case UploadPodcastRequestStatus.podcastCreatedSucess:
          return Defaults.defaultButton(
            onPressed: () {
              myPodcastBloc.add(const PickPodcastFileEvent());
            },
            context: context,
            text: AppStrings.pickAFile.tr(),
          );
        case UploadPodcastRequestStatus.error:
          return Defaults.defaultButton(
            onPressed: () {
              myPodcastBloc.add(const PickPodcastFileEvent());
            },
            context: context,
            text: AppStrings.pickAFile.tr(),
          );
      }
    });
  }
}
