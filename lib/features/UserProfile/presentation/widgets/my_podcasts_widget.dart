import 'dart:async';

import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/podcast_card_widget.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import '../../../../core/constants/params.dart';
import '../../../../core/utl/utls.dart';

class MyPodcastsWidget extends StatelessWidget {
  const MyPodcastsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserprofileBloc, UserprofileState>(
      builder: (context, state) {
        final userProfileBloc = BlocProvider.of<UserprofileBloc>(context);
        final commonPlayPodcastBloc =
            BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);
        switch (state.myPodCastequestStatus) {
          case MyPodCastRequestStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case MyPodCastRequestStatus.success:
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: ListView.builder(
                  itemCount: state.myPodcastEntite.length,
                  itemBuilder: (context, index) {
                    return BlocBuilder<CommonPlayingPodcastBlocBloc,
                        CommonPlayingPodcastBlocState>(
                      builder: (context, commonPlayPodcastBlocState) =>
                          PodcastCardWidget(
                              isLiked: state.myPodcastEntite[index].isLiked,
                              podcastDurathion: commonPlayPodcastBloc
                                  .getCurrentPlayingPosition(
                                currentPosition:
                                    commonPlayPodcastBlocState.currentPosition,
                                podcastId:
                                    state.myPodcastEntite[index].podcastId,
                                podcastDuration: state.myPodcastEntite[index]
                                    .podcastInfo.podcastDuration,
                              ),
                              podcastLikes: state
                                  .myPodcastEntite[index].podcastLikesCount,
                              podcastName:
                                  state.myPodcastEntite[index].podcastName,
                              onPressedOnCard: () {},
                              onPressedOnUserPhoto: () {},
                              onPressedOnLikeButton: () {
                                if (state.myPodcastEntite[index].isLiked) {
                                  userProfileBloc.add(
                                    LikeRemoveMyPodcastEvent(
                                      accessToken: ConstVar.accessToken,
                                      podcastId: state
                                          .myPodcastEntite[index].podcastId,
                                    ),
                                  );
                                } else {
                                  userProfileBloc.add(
                                    LikeAddMyPodcastEvent(
                                      accessToken: ConstVar.accessToken,
                                      podcastId: state
                                          .myPodcastEntite[index].podcastId,
                                    ),
                                  );
                                }
                              },
                              podcastPhoto: state.myPodcastEntite[index]
                                  .podcastUserInfo.userImage,
                              podcastUserName: state.myPodcastEntite[index]
                                  .podcastUserInfo.userName,
                              onPressedDownload: () {
                                if (currentDownloadingPodcastId == '') {
                                  downloadProgress = StreamController();
                                }
                              },
                              onPressedPlay: () {
                                commonPlayPodcastBloc.onPressedOnPlay(
                                    podcastId:
                                        state.myPodcastEntite[index].podcastId,
                                    podcastUrl: state.myPodcastEntite[index]
                                        .podcastInfo.podcastUrl,
                                    podcastName: state
                                        .myPodcastEntite[index].podcastName,
                                    podcastPhoto: state.myPodcastEntite[index]
                                        .podcastUserInfo.userImage,
                                    podcastUserName: state
                                        .myPodcastEntite[index]
                                        .podcastUserInfo
                                        .userName);
                              },
                              podcastId: state.myPodcastEntite[index].podcastId,
                              onPressedOnLikesCount: () {
                                if (state.myPodcastEntite[index]
                                        .podcastLikesCount !=
                                    0) {
                                  Navigator.of(context).pushNamed(
                                      AppRoutesNames.podcastUsersLikesScreen,
                                      arguments: LikesUsersScreenParams(
                                          podcastId: state
                                              .myPodcastEntite[index]
                                              .podcastId));
                                }
                              }),
                    );
                  }),
            );
          case MyPodCastRequestStatus.error:
            return Center(
              child: Text(state.errorMessage),
            );
        }
      },
    );
  }
}