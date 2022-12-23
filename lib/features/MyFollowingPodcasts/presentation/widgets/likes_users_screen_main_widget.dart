import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/presentation/bloc/podcast_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/users_card_widget.dart';

class LikesUsersScreenMainWidget extends StatelessWidget {
  const LikesUsersScreenMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PodcastBloc, PodcastState>(
      builder: (context, state) => ListView.builder(
          itemCount: state.podcastLikesUsersEntitie.length,
          itemBuilder: (context, index) {
            return UserCardWidget(
              userName: state.podcastLikesUsersEntitie[index]
                  .podcastUserInfoEntitie.userName,
              userPhoto: state.podcastLikesUsersEntitie[index]
                  .podcastUserInfoEntitie.userImage,
              createdAt: state.podcastLikesUsersEntitie[index].createdAt,
            );
          }),
    );
  }
}
