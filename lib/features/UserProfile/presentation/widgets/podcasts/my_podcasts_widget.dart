import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/params.dart';
import '../../../../../core/utl/utls.dart';
import 'main_my_podcast_widget.dart';

class MyPodcastsWidget extends StatelessWidget {
  const MyPodcastsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userprofileBloc = BlocProvider.of<UserProfileBloc>(context);
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        switch (state.myPodCastequestStatus) {
          case MyPodCastRequestStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case MyPodCastRequestStatus.success:
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Column(children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Defaults.defaultTextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          AppRoutesNames.uploadPodcastScreen,
                          arguments:
                              UploadPodcastScreenParams(userprofileBloc));
                    },
                    child: Text(
                      'Upload Podcast',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                Expanded(
                  child: MainMyPodcastWidget(
                    myPodcastEntite: state.myPodcastEntite,
                  ),
                ),
              ]),
            );
          case MyPodCastRequestStatus.error:
            return Center(
              child: Text(state.errorMessage),
            );
        }
      },
    );
  }
}
