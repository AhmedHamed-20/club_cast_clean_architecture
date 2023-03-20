import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_podcast_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utl/utls.dart';
import '../../../../core/widgets/defaults.dart';
import '../../../../core/widgets/podcast_card_widgets/podcast_card_widget.dart';
import '../bloc/otherusersprofiles_bloc.dart';

late ScrollController otherUserPodcastScrollController;
bool isEndOfOtherUserPodcastData = false;
int otherUserPodcastPage = 2;

class MainOtherUserPodcastWidget extends StatefulWidget {
  const MainOtherUserPodcastWidget(
      {super.key, required this.otherUserPodcastEntitie, required this.userId});
  final OtherUserPodcastEntity otherUserPodcastEntitie;
  final String userId;

  @override
  State<MainOtherUserPodcastWidget> createState() =>
      _MainOtherUserPodcastWidgetState();
}

class _MainOtherUserPodcastWidgetState
    extends State<MainOtherUserPodcastWidget> {
  @override
  void initState() {
    super.initState();
    listenToScrollController();
  }

  @override
  void dispose() {
    disposeOtherUserPodcastScrollController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otherUserProfileBloc = BlocProvider.of<OtherUserProfileBloc>(context);
    final commonPlayingPodcastBloc =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: RefreshIndicator(
        onRefresh: () async {
          otherUserProfileBloc.add(OtherUserPodcastsGetEvent(
              accessToken: ConstVar.accessToken, userId: widget.userId));
        },
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: otherUserPodcastScrollController,
            itemCount: widget.otherUserPodcastEntitie
                    .otherUserPodcastDataEntitie.length +
                1,
            itemBuilder: (context, index) {
              if (index <
                  widget.otherUserPodcastEntitie.otherUserPodcastDataEntitie
                      .length) {
                return BlocBuilder<CommonPlayingPodcastBlocBloc,
                        CommonPlayingPodcastBlocState>(
                    builder: (context, commonPlayPodcastBlocState) {
                  final defaultPodcastCallBackParams =
                      DefaultPodcastCallBackParams(
                    basePodcastEntitie: widget.otherUserPodcastEntitie
                        .otherUserPodcastDataEntitie[index],
                    commonPlayingPodcastBloc: commonPlayingPodcastBloc,
                    context: context,
                    state: commonPlayPodcastBlocState,
                  );
                  return PodcastCardWidget(
                    onPressedOnLike: () {
                      if (commonPlayPodcastBlocState.podcastLikeStatus ==
                          PodcastLikeStatus.loading) {
                        return;
                      }
                      commonPlayingPodcastBloc.onPressedOnLikeLogic(
                          serverLikeStatus: widget.otherUserPodcastEntitie
                              .otherUserPodcastDataEntitie[index].isLiked,
                          podcastLocalStatus:
                              commonPlayPodcastBlocState.podcastsLikesStatusMap,
                          podcastId: widget.otherUserPodcastEntitie
                              .otherUserPodcastDataEntitie[index].podcastId,
                          podcastBloc: otherUserProfileBloc,
                          podcastCountEvent: UpdatePodcastLikesCountEvent(
                              podcastId: widget.otherUserPodcastEntitie
                                  .otherUserPodcastDataEntitie[index].podcastId,
                              isLiked: widget.otherUserPodcastEntitie
                                  .otherUserPodcastDataEntitie[index].isLiked));
                    },
                    podcastEntitie: widget.otherUserPodcastEntitie
                        .otherUserPodcastDataEntitie[index],
                    podcastCardCallBacksParams: defaultPodcastCallBackParams
                        .defaultPodcastCallBackParams(),
                    podcastDurathion:
                        commonPlayingPodcastBloc.getCurrentPlayingPosition(
                      currentPosition:
                          commonPlayPodcastBlocState.currentPosition,
                      podcastId: widget.otherUserPodcastEntitie
                          .otherUserPodcastDataEntitie[index].podcastId,
                      podcastDuration: widget
                          .otherUserPodcastEntitie
                          .otherUserPodcastDataEntitie[index]
                          .podcastInfo
                          .podcastDuration,
                    ),
                  );
                });
              } else {
                return BlocBuilder<OtherUserProfileBloc, OtherUserProfileState>(
                  builder: (context, state) {
                    return state.isEndOfPodcastData
                        ? const SizedBox.shrink()
                        : const Padding(
                            padding: EdgeInsets.all(AppPadding.p8),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                  },
                );
              }
            }),
      ),
    );
  }

  void listenToScrollController() {
    final otherUserProfileBloc = BlocProvider.of<OtherUserProfileBloc>(context);
    otherUserPodcastScrollController = ScrollController();
    otherUserPodcastScrollController.addListener(() {
      if (otherUserPodcastScrollController.position.pixels ==
              otherUserPodcastScrollController.position.maxScrollExtent &&
          isEndOfOtherUserPodcastData == false) {
        otherUserProfileBloc.add(OtherUserPodcastsGetMoreEvent(
            accessToken: ConstVar.accessToken,
            userId: widget.userId,
            page: otherUserPodcastPage));
        otherUserPodcastPage++;
      }
    });
  }

  void disposeOtherUserPodcastScrollController() {
    otherUserPodcastPage = 2;
    otherUserPodcastScrollController.dispose();
    isEndOfOtherUserPodcastData = false;
  }
}
