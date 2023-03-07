import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';
import '../../../../core/widgets/defaults.dart';
import '../../../../core/widgets/podcast_card_widgets/podcast_card_widget.dart';
import '../bloc/search_bloc.dart';

class PodcastSearchMainWidget extends StatelessWidget {
  const PodcastSearchMainWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final commonPlayingPodcastBloc =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);
    final searchPodcast = BlocProvider.of<SearchBloc>(context);
    return BlocBuilder<CommonPlayingPodcastBlocBloc,
        CommonPlayingPodcastBlocState>(builder: (context, state) {
      return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, searchState) => ListView.builder(
            itemCount: searchState
                .podcastSearchEntitie.podcastInformationEntitie.length,
            itemBuilder: (context, index) {
              final defaultPodcastCallBackParams = DefaultPodcastCallBackParams(
                basePodcastEntitie: searchPodcast.state.podcastSearchEntitie
                    .podcastInformationEntitie[index],
                commonPlayingPodcastBloc: commonPlayingPodcastBloc,
                context: context,
                state: state,
              );
              return Padding(
                padding: EdgeInsets.only(
                    bottom: index ==
                            searchState.podcastSearchEntitie
                                .podcastInformationEntitie.length
                        ? AppPadding.p60
                        : 0),
                child: PodcastCardWidget(
                  onPressedOnLike: () {
                    if (state.podcastLikeStatus == PodcastLikeStatus.loading) {
                      return;
                    }
                    commonPlayingPodcastBloc.onPressedOnLikeLogic(
                      serverLikeStatus: searchState.podcastSearchEntitie
                          .podcastInformationEntitie[index].isLiked,
                      podcastLocalStatus: state.podcastsLikesStatusMap,
                      podcastId: searchState.podcastSearchEntitie
                          .podcastInformationEntitie[index].podcastId,
                      podcastBloc: searchPodcast,
                      podcastCountEvent: UpdatePodcastLikesCountEvent(
                        podcastId: searchState.podcastSearchEntitie
                            .podcastInformationEntitie[index].podcastId,
                        isLiked: searchState.podcastSearchEntitie
                            .podcastInformationEntitie[index].isLiked,
                        isSearch: true,
                      ),
                    );
                  },
                  podcastEntitie: searchState
                      .podcastSearchEntitie.podcastInformationEntitie[index],
                  isMyProfile: false,
                  podcastCardCallBacksParams: defaultPodcastCallBackParams
                      .defaultPodcastCallBackParams(),
                  podcastDurathion:
                      commonPlayingPodcastBloc.getCurrentPlayingPosition(
                    currentPosition: state.currentPosition,
                    podcastId: searchState.podcastSearchEntitie
                        .podcastInformationEntitie[index].podcastId,
                    podcastDuration: searchState
                        .podcastSearchEntitie
                        .podcastInformationEntitie[index]
                        .podcastInfo
                        .podcastDuration,
                  ),
                ),
              );
            }),
      );
    });
  }
}
