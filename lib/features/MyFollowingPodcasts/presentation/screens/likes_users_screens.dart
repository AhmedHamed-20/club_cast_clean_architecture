import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/presentation/bloc/podcast_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';
import '../widgets/likes_users_screen_main_widget.dart';

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
    BlocProvider.of<PodcastBloc>(context).add(
      GetPodcastLikesUsersEvent(
        accessToken: ConstVar.accessToken,
        podcastId: widget.podcastId,
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
          'Podcast Likes',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocBuilder<PodcastBloc, PodcastState>(
        builder: (context, state) {
          switch (state.myFollowingPodcastsUsersLikesRequestStatus) {
            case MyFollowingPodcastsUsersLikesRequestStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case MyFollowingPodcastsUsersLikesRequestStatus.success:
              return const LikesUsersScreenMainWidget();
            case MyFollowingPodcastsUsersLikesRequestStatus.error:
              return Center(
                child: Text(state.errorMessage),
              );
          }
        },
      ),
    );
  }
}
