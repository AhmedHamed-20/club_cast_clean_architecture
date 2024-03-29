import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/services/service_locator.dart';
import 'package:club_cast_clean_architecture/core/widgets/error_screen.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/presentation/bloc/podcast_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';
import '../widgets/main_my_following_podcasts_widget.dart';

class MyFollowingPodcastScreen extends StatelessWidget {
  const MyFollowingPodcastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => servicelocator<PodcastBloc>()
          ..add(
            GetMyFollowingPodcastsEvent(
              accessToken: ConstVar.accessToken,
            ),
          ),
        child: BlocBuilder<PodcastBloc, PodcastState>(
          builder: (context, state) {
            switch (state.myFollowingPodcastsRequestStatus) {
              case MyFollowingPodcastsRequestStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case MyFollowingPodcastsRequestStatus.success:
                return const MainMyFollowingPodcastsWidget();
              case MyFollowingPodcastsRequestStatus.error:
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
                      BlocProvider.of<PodcastBloc>(context)
                          .add(GetMyFollowingPodcastsEvent(
                        accessToken: ConstVar.accessToken,
                      ));
                    },
                  );
                }
            }
          },
        ));
  }
}
