import '../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/base_podcast_entitie/base_podcast_entitie.dart';
import '../constants/constants.dart';
import '../constants/media_query_of_methods.dart';

class MainPodcastInfoWidget extends StatelessWidget {
  const MainPodcastInfoWidget(
      {super.key,
      required this.podcastInformationEntitie,
      required this.backGroundColor});
  final BasePodcastEntitie podcastInformationEntitie;
  final Color backGroundColor;
  @override
  Widget build(BuildContext context) {
    var commonPodcastPlayBloc =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          podcastInformationEntitie.podcastUserInfo.userName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQueryOfMethods.getAppWidth(context) * 0.6,
                  height: MediaQueryOfMethods.getAppHeight(context) * 0.35,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: backGroundColor,
                        blurRadius: 50,
                        spreadRadius: 1,
                        offset: const Offset(70, 50),
                      ),
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.6),
                        blurRadius: 50,
                        spreadRadius: 30,
                        offset: const Offset(70, 50),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQueryOfMethods.getAppWidth(context) * 0.6,
                        height:
                            MediaQueryOfMethods.getAppHeight(context) * 0.35,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.r10),
                          child: Image.network(
                            podcastInformationEntitie.podcastUserInfo.userImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppHeight.h10,
                      ),
                      Text(
                        podcastInformationEntitie.podcastName,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        DateTimeFormat.format(
                          DateTime.parse(podcastInformationEntitie.createdAt),
                          format: 'D, M j, H:i',
                        ),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQueryOfMethods.getAppHeight(context) * 0.1,
            ),
            BlocBuilder<CommonPlayingPodcastBlocBloc,
                CommonPlayingPodcastBlocState>(
              builder: (context, state) => Slider(
                onChanged: (value) {
                  if (currentPlayingPodcastsId ==
                      podcastInformationEntitie.podcastId) {
                    commonPodcastPlayBloc.add(SeekToEvent(value.toInt()));
                  }
                },
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Theme.of(context).colorScheme.background,
                value: currentPlayingPodcastsId ==
                        podcastInformationEntitie.podcastId
                    ? state.currentPosition.toDouble()
                    : 0,
                min: 0,
                max: podcastInformationEntitie.podcastInfo.podcastDuration,
              ),
            ),
            const SizedBox(
              height: AppHeight.h6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<CommonPlayingPodcastBlocBloc,
                    CommonPlayingPodcastBlocState>(
                  builder: (context, state) => Text(
                    covertDurationTime(
                      commonPodcastPlayBloc.getCurrentPlayingPosition(
                        currentPosition: state.currentPosition,
                        podcastId: podcastInformationEntitie.podcastId,
                        podcastDuration: podcastInformationEntitie
                            .podcastInfo.podcastDuration,
                      ),
                    ),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Text(
                  covertDurationTime(
                    podcastInformationEntitie.podcastInfo.podcastDuration,
                  ),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            SizedBox(
              height: MediaQueryOfMethods.getAppHeight(context) * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 35,
                  onPressed: () {
                    if (currentPlayingPodcastsId ==
                        podcastInformationEntitie.podcastId) {
                      commonPodcastPlayBloc.add(const SeekByEvent(-10));
                    }
                  },
                  icon: Icon(
                    Icons.replay_10,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                CircleAvatar(
                  radius: AppRadius.r35,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        commonPodcastPlayBloc.onPressedOnPlay(
                            podcastId: podcastInformationEntitie.podcastId,
                            podcastName: podcastInformationEntitie.podcastName,
                            podcastPhoto: podcastInformationEntitie
                                .podcastUserInfo.userImage,
                            podcastUrl: podcastInformationEntitie
                                .podcastInfo.podcastUrl,
                            podcastUserName: podcastInformationEntitie
                                .podcastUserInfo.userName);
                      },
                      icon: Icon(
                        currentPlayingPodcastsId ==
                                podcastInformationEntitie.podcastId
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (currentPlayingPodcastsId ==
                        podcastInformationEntitie.podcastId) {
                      commonPodcastPlayBloc.add(const SeekByEvent(10));
                    }
                  },
                  iconSize: 35,
                  icon: Icon(
                    Icons.forward_10,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
