import 'dart:async';

import '../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/presentation/bloc/podcast_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/params.dart';
import '../../../../core/widgets/podcast_card_widget.dart';

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
    final podcastBloc = BlocProvider.of<PodcastBloc>(context);
    final commanPlayPodcast =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);
    return BlocBuilder<CommonPlayingPodcastBlocBloc,
        CommonPlayingPodcastBlocState>(
      builder: (context, state) {
        return PodcastCardWidget(
          podcastId:
              myFollowingPodcasts.podcastInformationEntitie[index].podcastId,
          onPressedOnCard: () {
            Navigator.of(context).pushNamed(AppRoutesNames.podcastInfoScreen,
                arguments:
                    myFollowingPodcasts.podcastInformationEntitie[index]);
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
          onPressedDownload: () {
            if (currentDownloadingPodcastId == '') {
              downloadProgress = StreamController();
              commanPlayPodcast.add(PodcastDownloadEvent(
                  podcastUrl: myFollowingPodcasts
                      .podcastInformationEntitie[index].podcastInfo.podcastUrl,
                  savedPath: commanPlayPodcast
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
            commanPlayPodcast.onPressedOnPlay(
                podcastId: myFollowingPodcasts
                    .podcastInformationEntitie[index].podcastId,
                podcastUrl: myFollowingPodcasts
                    .podcastInformationEntitie[index].podcastInfo.podcastUrl,
                podcastName: myFollowingPodcasts
                    .podcastInformationEntitie[index].podcastName,
                podcastPhoto: myFollowingPodcasts
                    .podcastInformationEntitie[index].podcastUserInfo.userImage,
                podcastUserName: myFollowingPodcasts
                    .podcastInformationEntitie[index].podcastUserInfo.userName);
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
          onPressedOnLikeButton: () {
            if (myFollowingPodcasts.podcastInformationEntitie[index].isLiked) {
              podcastBloc.add(
                RemovePodcastLikeEvent(
                  accessToken: ConstVar.accessToken,
                  podcastId: myFollowingPodcasts
                      .podcastInformationEntitie[index].podcastId,
                ),
              );
            } else {
              podcastBloc.add(
                AddLikeToPodcastEvent(
                  accessToken: ConstVar.accessToken,
                  podcastId: myFollowingPodcasts
                      .podcastInformationEntitie[index].podcastId,
                ),
              );
            }
          },
          isLiked: myFollowingPodcasts.podcastInformationEntitie[index].isLiked,
          podcastDurathion: commanPlayPodcast.getCurrentPlayingPosition(
            currentPosition: state.currentPosition,
            podcastId:
                myFollowingPodcasts.podcastInformationEntitie[index].podcastId,
            podcastDuration: myFollowingPodcasts
                .podcastInformationEntitie[index].podcastInfo.podcastDuration,
          ),
          podcastLikes: myFollowingPodcasts
              .podcastInformationEntitie[index].podcastLikesCount,
          podcastName:
              myFollowingPodcasts.podcastInformationEntitie[index].podcastName,
          podcastPhoto: myFollowingPodcasts
              .podcastInformationEntitie[index].podcastUserInfo.userImage,
          podcastUserName: myFollowingPodcasts
              .podcastInformationEntitie[index].podcastUserInfo.userName,
        );
      },
    );
  }
}
