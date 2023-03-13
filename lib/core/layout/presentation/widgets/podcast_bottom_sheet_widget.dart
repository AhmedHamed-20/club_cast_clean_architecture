import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_entitie.dart';
import 'package:club_cast_clean_architecture/core/routes/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';

class PodcastBottomSheetWidget extends StatelessWidget {
  const PodcastBottomSheetWidget({super.key, required this.basePodcastEntitie});
  final BasePodcastEntitie basePodcastEntitie;
  @override
  Widget build(BuildContext context) {
    final commonPlayingPodcast =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutesNames.podcastInfoScreen,
          arguments: basePodcastEntitie,
        );
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          color: AppColors.transparentColor,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    basePodcastEntitie.podcastName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        commonPlayingPodcast.add(const SeekByEvent(-10));
                      },
                      icon: Icon(
                        Icons.replay_10,
                        size: 35,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    CircleAvatar(
                      radius: AppRadius.r22,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: IconButton(
                        onPressed: () {
                          commonPlayingPodcast.onPressedOnPlay(
                            basePodcastEntitie: basePodcastEntitie,
                            context: context,
                          );
                        },
                        icon: Center(
                          child: BlocBuilder<CommonPlayingPodcastBlocBloc,
                              CommonPlayingPodcastBlocState>(
                            builder: (context, state) => Icon(
                              state.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        commonPlayingPodcast.add(PodcastStopPlaying(
                          basePodcastEntitie.podcastId,
                        ));
                      },
                      icon: Icon(
                        Icons.stop,
                        size: 35,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        commonPlayingPodcast.add(const SeekByEvent(10));
                      },
                      icon: Icon(
                        Icons.forward_10,
                        size: 35,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
