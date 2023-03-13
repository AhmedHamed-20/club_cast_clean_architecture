import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/likes_users_screen_main_widget.dart';
import '../../../utl/utls.dart';

class LikesUsersScreen extends StatefulWidget {
  const LikesUsersScreen({super.key, required this.podcastId});
  final String podcastId;
  @override
  State<LikesUsersScreen> createState() => _LikesUsersScreenState();
}

class _LikesUsersScreenState extends State<LikesUsersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CommonPlayingPodcastBlocBloc>(context).add(
      PodcastLikesUsersGetEvent(
        ConstVar.accessToken,
        widget.podcastId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          AppStrings.podcastLikes.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocBuilder<CommonPlayingPodcastBlocBloc,
          CommonPlayingPodcastBlocState>(
        builder: (context, state) {
          switch (state.podcastsUsersLikesRequestStatus) {
            case PodcastsUsersLikesRequestStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PodcastsUsersLikesRequestStatus.success:
              return const LikesUsersScreenMainWidget();
            case PodcastsUsersLikesRequestStatus.error:
              return Center(
                child: Text(state.errorMessage),
              );
          }
        },
      ),
    );
  }
}
