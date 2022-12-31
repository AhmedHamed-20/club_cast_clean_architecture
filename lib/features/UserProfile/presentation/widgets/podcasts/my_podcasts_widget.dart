import 'dart:async';

import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/podcast_card_widget.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/remove_podcast_alert_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import '../../../../core/constants/params.dart';
import '../../../../core/utl/utls.dart';

class MyPodcastsWidget extends StatelessWidget {
  const MyPodcastsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final commanPlayPodcast =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);
    return BlocBuilder<UserProfileBloc, UserprofileState>(
      builder: (context, state) {
        final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
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
                      isMyProfile: true,
                      onPressedOnRemove: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BlocProvider.value(
                                value: userProfileBloc,
                                child: RemovePodcastAlertDialogWidget(
                                  podcastId:
                                      state.myPodcastEntite[index].podcastId,
                                  podcastName:
                                      state.myPodcastEntite[index].podcastName,
                                ),
                              );
                            });
                      },
                      isLiked: state.myPodcastEntite[index].isLiked,
                      podcastDurathion:
                          commonPlayPodcastBloc.getCurrentPlayingPosition(
                        currentPosition:
                            commonPlayPodcastBlocState.currentPosition,
                        podcastId: state.myPodcastEntite[index].podcastId,
                        podcastDuration: state
                            .myPodcastEntite[index].podcastInfo.podcastDuration,
                      ),
                      podcastLikes:
                          state.myPodcastEntite[index].podcastLikesCount,
                      podcastName: state.myPodcastEntite[index].podcastName,
                      onPressedOnCard: () {
                        Navigator.of(context).pushNamed(
                            AppRoutesNames.podcastInfoScreen,
                            arguments: state.myPodcastEntite[index]);
                      },
                      onPressedOnUserPhoto: () {},
                      onPressedOnLikeButton: () {
                        if (state.myPodcastEntite[index].isLiked) {
                          userProfileBloc.add(
                            LikeRemoveMyPodcastEvent(
                              accessToken: ConstVar.accessToken,
                              podcastId: state.myPodcastEntite[index].podcastId,
                            ),
                          );
                        } else {
                          userProfileBloc.add(
                            LikeAddMyPodcastEvent(
                              accessToken: ConstVar.accessToken,
                              podcastId: state.myPodcastEntite[index].podcastId,
                            ),
                          );
                        }
                      },
                      podcastPhoto: state
                          .myPodcastEntite[index].podcastUserInfo.userImage,
                      podcastUserName:
                          state.myPodcastEntite[index].podcastUserInfo.userName,
                      onPressedDownload: () {
                        if (currentDownloadingPodcastId == '') {
                          downloadProgress = StreamController();

                          commanPlayPodcast.add(
                            PodcastDownloadEvent(
                              podcastUrl: state.myPodcastEntite[index]
                                  .podcastInfo.podcastUrl,
                              savedPath: commanPlayPodcast
                                  .getSavedPath(
                                      podcastName: state
                                          .myPodcastEntite[index].podcastName)
                                  .path,
                              podcastId: state.myPodcastEntite[index].podcastId,
                              downloadProgress: downloadProgress,
                            ),
                          );
                        }
                      },
                      onPressedPlay: () {
                        commonPlayPodcastBloc.onPressedOnPlay(
                          podcastId: state.myPodcastEntite[index].podcastId,
                          podcastUrl: state
                              .myPodcastEntite[index].podcastInfo.podcastUrl,
                          podcastName: state.myPodcastEntite[index].podcastName,
                          podcastPhoto: state
                              .myPodcastEntite[index].podcastUserInfo.userImage,
                          podcastUserName: state
                              .myPodcastEntite[index].podcastUserInfo.userName,
                        );
                      },
                      podcastId: state.myPodcastEntite[index].podcastId,
                      onPressedOnLikesCount: () {
                        if (state.myPodcastEntite[index].podcastLikesCount !=
                            0) {
                          Navigator.of(context).pushNamed(
                            AppRoutesNames.podcastUsersLikesScreen,
                            arguments: LikesUsersScreenParams(
                              podcastId: state.myPodcastEntite[index].podcastId,
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
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
