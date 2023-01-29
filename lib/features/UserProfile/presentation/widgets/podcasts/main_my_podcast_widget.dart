import 'dart:async';

import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/podcasts/remove_podcast_alert_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/params.dart';
import '../../../../../core/routes/app_route_names.dart';
import '../../../../../core/widgets/podcast_card_widgets/podcast_card_widget.dart';

class MainMyPodcastWidget extends StatelessWidget {
  const MainMyPodcastWidget({
    required this.myPodcastEntite,
    Key? key,
  }) : super(key: key);
  final List<MyPodcastEntite> myPodcastEntite;
  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    final commonPlayingPodcastBloc =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);
    return ListView.builder(
      itemCount: myPodcastEntite.length,
      itemBuilder: (context, index) {
        return BlocBuilder<CommonPlayingPodcastBlocBloc,
            CommonPlayingPodcastBlocState>(
          builder: (context, commonPlayPodcastBlocState) => PodcastCardWidget(
            podcastEntitie: myPodcastEntite[index],
            isMyProfile: true,
            podcastCardCallBacksParams: PodcastCardCallBacksParams(
              onPressedOnRemove: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return BlocProvider.value(
                        value: userProfileBloc,
                        child: RemovePodcastAlertDialogWidget(
                          podcastId: myPodcastEntite[index].podcastId,
                          podcastName: myPodcastEntite[index].podcastName,
                        ),
                      );
                    });
              },
              onPressedOnLikeButton: () {
                commonPlayingPodcastBloc.onPressedOnLikeLogic(
                  podcastId: myPodcastEntite[index].podcastId,
                  podcastLocalStatus:
                      commonPlayPodcastBlocState.podcastsLikesStatus,
                  serverLikeStatus: myPodcastEntite[index].isLiked,
                );
              },
              onPressedOnCard: () {
                Navigator.of(context).pushNamed(
                    AppRoutesNames.podcastInfoScreen,
                    arguments: myPodcastEntite[index]);
              },
              onPressedOnUserPhoto: () {},
              onPressedDownload: () {
                if (currentDownloadingPodcastId == '') {
                  downloadProgress = StreamController();

                  commonPlayingPodcastBloc.add(
                    PodcastDownloadEvent(
                      podcastUrl: myPodcastEntite[index].podcastInfo.podcastUrl,
                      savedPath: commonPlayingPodcastBloc
                          .getSavedPath(
                              podcastName: myPodcastEntite[index].podcastName)
                          .path,
                      podcastId: myPodcastEntite[index].podcastId,
                      downloadProgress: downloadProgress,
                    ),
                  );
                }
              },
              onPressedPlay: () {
                commonPlayingPodcastBloc.onPressedOnPlay(
                  podcastId: myPodcastEntite[index].podcastId,
                  podcastUrl: myPodcastEntite[index].podcastInfo.podcastUrl,
                  podcastName: myPodcastEntite[index].podcastName,
                  podcastPhoto:
                      myPodcastEntite[index].podcastUserInfo.userImage,
                  podcastUserName:
                      myPodcastEntite[index].podcastUserInfo.userName,
                );
              },
              onPressedOnLikesCount: () {
                if (myPodcastEntite[index].podcastLikesCount != 0) {
                  Navigator.of(context).pushNamed(
                    AppRoutesNames.podcastUsersLikesScreen,
                    arguments: LikesUsersScreenParams(
                      podcastId: myPodcastEntite[index].podcastId,
                    ),
                  );
                }
              },
            ),
            podcastDurathion:
                commonPlayingPodcastBloc.getCurrentPlayingPosition(
              currentPosition: commonPlayPodcastBlocState.currentPosition,
              podcastId: myPodcastEntite[index].podcastId,
              podcastDuration:
                  myPodcastEntite[index].podcastInfo.podcastDuration,
            ),
          ),
        );
      },
    );
  }
}
