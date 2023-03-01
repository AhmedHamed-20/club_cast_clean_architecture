import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_podcast_entitie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/defaults.dart';
import '../../../../core/widgets/podcast_card_widgets/podcast_card_widget.dart';
import '../bloc/otherusersprofiles_bloc.dart';
import 'other_user_podcasts_widget.dart';

class MainOtherUserPodcastWidget extends StatelessWidget {
  const MainOtherUserPodcastWidget(
      {super.key, required this.otherUserPodcastEntitie, required this.userId});
  final OtherUserPodcastEntitie otherUserPodcastEntitie;
  final String userId;
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
              accessToken: ConstVar.accessToken, userId: userId));
        },
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: otherUserPodcastScrollController,
            itemCount:
                otherUserPodcastEntitie.otherUserPodcastDataEntitie.length + 1,
            itemBuilder: (context, index) {
              if (index <
                  otherUserPodcastEntitie.otherUserPodcastDataEntitie.length) {
                return BlocBuilder<CommonPlayingPodcastBlocBloc,
                        CommonPlayingPodcastBlocState>(
                    builder: (context, commonPlayPodcastBlocState) {
                  final defaultPodcastCallBackParams =
                      DefaultPodcastCallBackParams(
                    basePodcastEntitie: otherUserPodcastEntitie
                        .otherUserPodcastDataEntitie[index],
                    commonPlayingPodcastBloc: commonPlayingPodcastBloc,
                    context: context,
                    state: commonPlayPodcastBlocState,
                  );
                  return PodcastCardWidget(
                    podcastEntitie: otherUserPodcastEntitie
                        .otherUserPodcastDataEntitie[index],
                    podcastCardCallBacksParams: defaultPodcastCallBackParams
                        .defaultPodcastCallBackParams(),
                    podcastDurathion:
                        commonPlayingPodcastBloc.getCurrentPlayingPosition(
                      currentPosition:
                          commonPlayPodcastBlocState.currentPosition,
                      podcastId: otherUserPodcastEntitie
                          .otherUserPodcastDataEntitie[index].podcastId,
                      podcastDuration: otherUserPodcastEntitie
                          .otherUserPodcastDataEntitie[index]
                          .podcastInfo
                          .podcastDuration,
                    ),
                  );
                });
              } else {
                return isEndOfOtherUserPodcastData
                    ? const SizedBox.shrink()
                    : const Padding(
                        padding: EdgeInsets.all(AppPadding.p8),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
              }
            }),
      ),
    );
  }
}
