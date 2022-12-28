import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/users_card_widget.dart';

class LikesUsersScreenMainWidget extends StatelessWidget {
  const LikesUsersScreenMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommonPlayingPodcastBlocBloc,
        CommonPlayingPodcastBlocState>(
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
