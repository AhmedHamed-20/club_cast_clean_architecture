import 'dart:async';

import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_podcast_entitie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/params.dart';
import '../../../../core/widgets/podcast_card_widget.dart';
import 'other_user_podcasts_widget.dart';

class MainOtherUserPodcastWidget extends StatelessWidget {
  const MainOtherUserPodcastWidget(
      {super.key, required this.otherUserPodcastEntitie});
  final OtherUserPodcastEntitie otherUserPodcastEntitie;
  @override
  Widget build(BuildContext context) {
    final commonPlayingPodcastBloc =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          controller: otherUserPodcastScrollController,
          itemCount:
              otherUserPodcastEntitie.otherUserPodcastDataEntitie.length + 1,
          itemBuilder: (context, index) {
            if (index <
                otherUserPodcastEntitie.otherUserPodcastDataEntitie.length) {
              return BlocBuilder<CommonPlayingPodcastBlocBloc,
                  CommonPlayingPodcastBlocState>(
                builder: (context, commonPlayPodcastBlocState) =>
                    PodcastCardWidget(
                  isLiked: otherUserPodcastEntitie
                      .otherUserPodcastDataEntitie[index].isLiked,
                  podcastDurathion:
                      commonPlayingPodcastBloc.getCurrentPlayingPosition(
                    currentPosition: commonPlayPodcastBlocState.currentPosition,
                    podcastId: otherUserPodcastEntitie
                        .otherUserPodcastDataEntitie[index].podcastId,
                    podcastDuration: otherUserPodcastEntitie
                        .otherUserPodcastDataEntitie[index]
                        .podcastInfo
                        .podcastDuration,
                  ),
                  podcastLikes: otherUserPodcastEntitie
                      .otherUserPodcastDataEntitie[index].podcastLikesCount,
                  podcastName: otherUserPodcastEntitie
                      .otherUserPodcastDataEntitie[index].podcastName,
                  onPressedOnCard: () {
                    Navigator.of(context).pushNamed(
                        AppRoutesNames.podcastInfoScreen,
                        arguments: otherUserPodcastEntitie
                            .otherUserPodcastDataEntitie[index]);
                  },
                  onPressedOnUserPhoto: () {},
                  onPressedOnLikeButton: () {},
                  podcastPhoto: otherUserPodcastEntitie
                      .otherUserPodcastDataEntitie[index]
                      .podcastUserInfo
                      .userImage,
                  podcastUserName: otherUserPodcastEntitie
                      .otherUserPodcastDataEntitie[index]
                      .podcastUserInfo
                      .userName,
                  onPressedDownload: () {
                    if (currentDownloadingPodcastId == '') {
                      downloadProgress = StreamController();

                      commonPlayingPodcastBloc.add(
                        PodcastDownloadEvent(
                          podcastUrl: otherUserPodcastEntitie
                              .otherUserPodcastDataEntitie[index]
                              .podcastInfo
                              .podcastUrl,
                          savedPath: commonPlayingPodcastBloc
                              .getSavedPath(
                                  podcastName: otherUserPodcastEntitie
                                      .otherUserPodcastDataEntitie[index]
                                      .podcastName)
                              .path,
                          podcastId: otherUserPodcastEntitie
                              .otherUserPodcastDataEntitie[index].podcastId,
                          downloadProgress: downloadProgress,
                        ),
                      );
                    }
                  },
                  onPressedPlay: () {
                    commonPlayingPodcastBloc.onPressedOnPlay(
                      podcastId: otherUserPodcastEntitie
                          .otherUserPodcastDataEntitie[index].podcastId,
                      podcastUrl: otherUserPodcastEntitie
                          .otherUserPodcastDataEntitie[index]
                          .podcastInfo
                          .podcastUrl,
                      podcastName: otherUserPodcastEntitie
                          .otherUserPodcastDataEntitie[index].podcastName,
                      podcastPhoto: otherUserPodcastEntitie
                          .otherUserPodcastDataEntitie[index]
                          .podcastUserInfo
                          .userImage,
                      podcastUserName: otherUserPodcastEntitie
                          .otherUserPodcastDataEntitie[index]
                          .podcastUserInfo
                          .userName,
                    );
                  },
                  podcastId: otherUserPodcastEntitie
                      .otherUserPodcastDataEntitie[index].podcastId,
                  onPressedOnLikesCount: () {
                    if (otherUserPodcastEntitie
                            .otherUserPodcastDataEntitie[index]
                            .podcastLikesCount !=
                        0) {
                      Navigator.of(context).pushNamed(
                        AppRoutesNames.podcastUsersLikesScreen,
                        arguments: LikesUsersScreenParams(
                          podcastId: otherUserPodcastEntitie
                              .otherUserPodcastDataEntitie[index].podcastId,
                        ),
                      );
                    }
                  },
                ),
              );
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
    );
  }
}
