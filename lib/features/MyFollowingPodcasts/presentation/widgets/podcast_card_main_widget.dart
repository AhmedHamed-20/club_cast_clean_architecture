import 'dart:async';

import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entitie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import '../../../../core/constants/params.dart';
import '../../../../core/routes/app_route_names.dart';
import '../../../../core/widgets/podcast_card_widgets/podcast_card_widget.dart';

class PodcastCardMainWdget extends StatelessWidget {
  const PodcastCardMainWdget({
    Key? key,
    required this.myFollowingPodcasts,
    required this.index,
  }) : super(key: key);
  final PodcastEntitie myFollowingPodcasts;
  final int index;
  @override
  Widget build(BuildContext context) {
    final commonPlayPodcast =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);
    return BlocBuilder<CommonPlayingPodcastBlocBloc,
        CommonPlayingPodcastBlocState>(
      builder: (context, state) {
        return PodcastCardWidget(
          podcastEntitie: myFollowingPodcasts.podcastInformationEntitie[index],
          podcastCardCallBacksParams: PodcastCardCallBacksParams(
            onPressedOnLikeButton: () {
              commonPlayPodcast.onPressedOnLikeLogic(
                  podcastId: myFollowingPodcasts
                      .podcastInformationEntitie[index].podcastId,
                  podcastLocalStatus: state.podcastsLikesStatus,
                  serverLikeStatus: myFollowingPodcasts
                      .podcastInformationEntitie[index].isLiked);
            },
            onPressedOnCard: () {
              Navigator.of(context).pushNamed(AppRoutesNames.podcastInfoScreen,
                  arguments:
                      myFollowingPodcasts.podcastInformationEntitie[index]);
            },
            onPressedOnUserPhoto: () {
              Navigator.of(context).pushNamed(
                AppRoutesNames.otherUserProfileScreen,
                arguments: OtherUserProfileScreenParams(
                  myFollowingPodcasts
                      .podcastInformationEntitie[index].podcastUserInfo.userId,
                ),
              );
            },
            onPressedDownload: () {
              if (currentDownloadingPodcastId == '') {
                downloadProgress = StreamController();
                commonPlayPodcast.add(PodcastDownloadEvent(
                    podcastUrl: myFollowingPodcasts
                        .podcastInformationEntitie[index]
                        .podcastInfo
                        .podcastUrl,
                    savedPath: commonPlayPodcast
                        .getSavedPath(
                            podcastName: myFollowingPodcasts
                                .podcastInformationEntitie[index].podcastName)
                        .path,
                    podcastId: myFollowingPodcasts
                        .podcastInformationEntitie[index].podcastId,
                    downloadProgress: downloadProgress));
              }
            },
            onPressedPlay: () {
              commonPlayPodcast.onPressedOnPlay(
                  podcastId: myFollowingPodcasts
                      .podcastInformationEntitie[index].podcastId,
                  podcastUrl: myFollowingPodcasts
                      .podcastInformationEntitie[index].podcastInfo.podcastUrl,
                  podcastName: myFollowingPodcasts
                      .podcastInformationEntitie[index].podcastName,
                  podcastPhoto: myFollowingPodcasts
                      .podcastInformationEntitie[index]
                      .podcastUserInfo
                      .userImage,
                  podcastUserName: myFollowingPodcasts
                      .podcastInformationEntitie[index]
                      .podcastUserInfo
                      .userName);
            },
            onPressedOnLikesCount: () {
              if (myFollowingPodcasts
                      .podcastInformationEntitie[index].podcastLikesCount !=
                  0) {
                Navigator.pushNamed(
                    context, AppRoutesNames.podcastUsersLikesScreen,
                    arguments: LikesUsersScreenParams(
                        podcastId: myFollowingPodcasts
                            .podcastInformationEntitie[index].podcastId));
              }
            },
          ),
          podcastDurathion: commonPlayPodcast.getCurrentPlayingPosition(
            currentPosition: state.currentPosition,
            podcastId:
                myFollowingPodcasts.podcastInformationEntitie[index].podcastId,
            podcastDuration: myFollowingPodcasts
                .podcastInformationEntitie[index].podcastInfo.podcastDuration,
          ),
        );
      },
    );
  }
}
