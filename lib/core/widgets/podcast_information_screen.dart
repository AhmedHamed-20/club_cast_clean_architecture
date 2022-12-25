import 'package:club_cast_clean_architecture/core/bloc/common_playing_podcast_bloc_bloc.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/presentation/widgets/main_my_following_podcasts_widget.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/base_podcast_entitie/base_podcast_entitie.dart';

class PodcastInformationScreen extends StatefulWidget {
  const PodcastInformationScreen(
      {super.key, required this.podcastInformationEntitie});
  final BasePodcastEntitie podcastInformationEntitie;
  @override
  State<PodcastInformationScreen> createState() =>
      _PodcastInformationScreenState();
}

class _PodcastInformationScreenState extends State<PodcastInformationScreen> {
  @override
  void initState() {
    final colors =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context).generateColor(
      image: widget.podcastInformationEntitie.podcastUserInfo.userImage,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          widget.podcastInformationEntitie.podcastUserInfo.userName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQueryOfMethods.getAppWidth(context) * 0.3,
                  height: MediaQueryOfMethods.getAppHeight(context) * 0.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.r10),
                    child: Image.network(
                      widget
                          .podcastInformationEntitie.podcastUserInfo.userImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: AppWidth.w10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.podcastInformationEntitie.podcastName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      DateTimeFormat.format(
                        DateTime.parse(
                            widget.podcastInformationEntitie.createdAt),
                        format: 'D, M j, H:i',
                      ),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQueryOfMethods.getAppHeight(context) * 0.3,
            ),
            Row(
              children: [
                Flexible(
                  child: LinearProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).backgroundColor,
                    value: 1,
                  ),
                ),
                const SizedBox(
                  width: AppWidth.w6,
                ),
                Text(
                  covertDurationTime(
                    widget
                        .podcastInformationEntitie.podcastInfo.podcastDuration,
                  ),
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
            const SizedBox(
              height: AppHeight.h20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.replay_10,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.play_arrow,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
