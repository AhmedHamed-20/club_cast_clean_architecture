import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/base_podcast_entitie/base_podcast_entitie.dart';
import '../../../../core/widgets/defaults.dart';
import '../../../../core/widgets/podcast_card_widgets/podcast_card_widget.dart';

class PodcastSearchMainWidget extends StatelessWidget {
  const PodcastSearchMainWidget({super.key, required this.basePodcastEntitie});
  final BasePodcastEntitie basePodcastEntitie;
  @override
  Widget build(BuildContext context) {
    final commonPlayingPodcastBloc =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);
    return BlocBuilder<CommonPlayingPodcastBlocBloc,
        CommonPlayingPodcastBlocState>(builder: (context, state) {
      final defaultPodcastCallBackParams = DefaultPodcastCallBackParams(
        basePodcastEntitie: basePodcastEntitie,
        commonPlayingPodcastBloc: commonPlayingPodcastBloc,
        context: context,
        state: state,
      );
      return PodcastCardWidget(
        podcastEntitie: basePodcastEntitie,
        isMyProfile: false,
        podcastCardCallBacksParams:
            defaultPodcastCallBackParams.defaultPodcastCallBackParams(),
        podcastDurathion: commonPlayingPodcastBloc.getCurrentPlayingPosition(
          currentPosition: state.currentPosition,
          podcastId: basePodcastEntitie.podcastId,
          podcastDuration: basePodcastEntitie.podcastInfo.podcastDuration,
        ),
      );
    });
  }
}
