import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entitie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import '../../../../core/widgets/defaults.dart';
import '../../../../core/widgets/podcast_card_widgets/podcast_card_widget.dart';

class PodcastCardMainWdget extends StatelessWidget {
  const PodcastCardMainWdget({
    Key? key,
    required this.podcastsEntitie,
    required this.index,
  }) : super(key: key);
  final PodcastEntitie podcastsEntitie;
  final int index;
  @override
  Widget build(BuildContext context) {
    final commonPlayPodcast =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);

    return BlocBuilder<CommonPlayingPodcastBlocBloc,
        CommonPlayingPodcastBlocState>(
      builder: (context, state) {
        final defaultPodcastCallBackParams = DefaultPodcastCallBackParams(
          basePodcastEntitie: podcastsEntitie.podcastInformationEntitie[index],
          commonPlayingPodcastBloc: commonPlayPodcast,
          context: context,
          state: state,
        );
        return PodcastCardWidget(
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
        );
      },
    );
  }
}
