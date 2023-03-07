import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/presentation/bloc/podcast_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import '../../../../core/widgets/defaults.dart';
import '../../../../core/widgets/podcast_card_widgets/podcast_card_widget.dart';

class MyFollowingPodcastCardMainWdget extends StatelessWidget {
  const MyFollowingPodcastCardMainWdget({
    Key? key,
    required this.podcastsEntitie,
    required this.index,
  }) : super(key: key);
  final MyFollowingPodcastEntitie podcastsEntitie;
  final int index;
  @override
  Widget build(BuildContext context) {
    final commonPlayPodcast =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);
    final myFollowingPodcastBloc = BlocProvider.of<PodcastBloc>(context);
    return BlocBuilder<CommonPlayingPodcastBlocBloc,
        CommonPlayingPodcastBlocState>(
      builder: (context, state) {
        final defaultPodcastCallBackParams = DefaultPodcastCallBackParams(
          basePodcastEntitie: podcastsEntitie.podcastInformationEntitie[index],
          commonPlayingPodcastBloc: commonPlayPodcast,
          context: context,
          state: state,
        );
        return Padding(
          padding: EdgeInsets.only(
              bottom:
                  index == podcastsEntitie.podcastInformationEntitie.length - 1
                      ? AppPadding.p60
                      : 0),
          child: PodcastCardWidget(
            onPressedOnLike: () {
              if (state.podcastLikeStatus == PodcastLikeStatus.loading) {
                return;
              }
              commonPlayPodcast.onPressedOnLikeLogic(
                podcastId:
                    podcastsEntitie.podcastInformationEntitie[index].podcastId,
                podcastLocalStatus: state.podcastsLikesStatusMap,
                serverLikeStatus:
                    podcastsEntitie.podcastInformationEntitie[index].isLiked,
                podcastBloc: myFollowingPodcastBloc,
                podcastCountEvent: UpdatePodcastLikesCountEvent(
                    isLiked: podcastsEntitie
                        .podcastInformationEntitie[index].isLiked,
                    podcastId: podcastsEntitie
                        .podcastInformationEntitie[index].podcastId),
              );
            },
            podcastEntitie: podcastsEntitie.podcastInformationEntitie[index],
            podcastCardCallBacksParams:
                defaultPodcastCallBackParams.defaultPodcastCallBackParams(),
            podcastDurathion: commonPlayPodcast.getCurrentPlayingPosition(
              currentPosition: state.currentPosition,
              podcastId:
                  podcastsEntitie.podcastInformationEntitie[index].podcastId,
              podcastDuration: podcastsEntitie
                  .podcastInformationEntitie[index].podcastInfo.podcastDuration,
            ),
          ),
        );
      },
    );
  }
}
