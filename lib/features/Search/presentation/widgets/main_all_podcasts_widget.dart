import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/core/widgets/podcast_card_widgets/podcast_card_widget.dart';
import 'package:club_cast_clean_architecture/features/Search/presentation/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/defaults.dart';
import '../../domain/entities/podcast_search_entitie.dart';
import '../screens/all_podcasts_screen.dart';

class MainAllPodcastWidget extends StatefulWidget {
  const MainAllPodcastWidget(
      {super.key, required this.podcastInformationEntitie});
  final PodcastSearchEntitie podcastInformationEntitie;
  @override
  State<MainAllPodcastWidget> createState() => _MainAllPodcastWidgetState();
}

class _MainAllPodcastWidgetState extends State<MainAllPodcastWidget> {
  @override
  Widget build(BuildContext context) {
    final commonPlayingPodcastBloc =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    return BlocBuilder<CommonPlayingPodcastBlocBloc,
        CommonPlayingPodcastBlocState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            searchBloc.add(
                AllPodcastEvent(accessToken: ConstVar.accessToken, page: 1));
          },
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: allPodcastScrollController,
              itemCount: widget.podcastInformationEntitie
                      .podcastInformationEntitie.length +
                  1,
              itemBuilder: (context, index) {
                if (index <
                    widget.podcastInformationEntitie.podcastInformationEntitie
                        .length) {
                  final defaultPodcastCallBackParams =
                      DefaultPodcastCallBackParams(
                    basePodcastEntitie: widget.podcastInformationEntitie
                        .podcastInformationEntitie[index],
                    commonPlayingPodcastBloc: commonPlayingPodcastBloc,
                    context: context,
                    state: state,
                  );
                  return Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: PodcastCardWidget(
                      onPressedOnLike: () {
                        if (state.podcastLikeStatus ==
                            PodcastLikeStatus.loading) {
                          return;
                        }
                        commonPlayingPodcastBloc.onPressedOnLikeLogic(
                          serverLikeStatus: widget.podcastInformationEntitie
                              .podcastInformationEntitie[index].isLiked,
                          podcastLocalStatus: state.podcastsLikesStatusMap,
                          podcastId: widget.podcastInformationEntitie
                              .podcastInformationEntitie[index].podcastId,
                          podcastBloc: searchBloc,
                          podcastCountEvent: UpdatePodcastLikesCountEvent(
                            podcastId: widget.podcastInformationEntitie
                                .podcastInformationEntitie[index].podcastId,
                            isLiked: widget.podcastInformationEntitie
                                .podcastInformationEntitie[index].isLiked,
                            isSearch: false,
                          ),
                        );
                      },
                      podcastDurathion:
                          commonPlayingPodcastBloc.getCurrentPlayingPosition(
                        currentPosition: state.currentPosition,
                        podcastId: widget.podcastInformationEntitie
                            .podcastInformationEntitie[index].podcastId,
                        podcastDuration: widget
                            .podcastInformationEntitie
                            .podcastInformationEntitie[index]
                            .podcastInfo
                            .podcastDuration,
                      ),
                      podcastEntitie: widget.podcastInformationEntitie
                          .podcastInformationEntitie[index],
                      podcastCardCallBacksParams: defaultPodcastCallBackParams
                          .defaultPodcastCallBackParams(),
                    ),
                  );
                } else {
                  if (isEndOfAllPodcasts) {
                    return const SizedBox.shrink();
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(AppPadding.p8),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }
              }),
        );
      },
    );
  }
}
