import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utl/utls.dart';
import '../../../../../core/widgets/defaults.dart';
import '../../bloc/userprofile_bloc.dart';

class PickFileButton extends StatelessWidget {
  const PickFileButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    return BlocBuilder<UserProfileBloc, UserprofileState>(
        builder: (context, state) {
      switch (state.uploadPodcastRequestStatus) {
        case UploadPodcastRequestStatus.idle:
          return Defaults.defaultButton(
            onPressed: () {
              userProfileBloc.add(const PickPodcastFileEvent());
            },
            context: context,
            text:
                state.pickedPodcastFilePath == '' ? 'Pick File' : 'Change File',
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
              userProfileBloc.add(const PickPodcastFileEvent());
            },
            context: context,
            text: 'Pick File',
          );
        case UploadPodcastRequestStatus.error:
          return Defaults.defaultButton(
            onPressed: () {
              userProfileBloc.add(const PickPodcastFileEvent());
            },
            context: context,
            text: 'Pick File',
          );
      }
    });
  }
}
