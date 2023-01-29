import 'package:flutter/material.dart';

import '../constants/base_podcast_entitie/base_podcast_entitie.dart';
import '../constants/constants.dart';
import '../constants/params.dart';

class PodcastDurationAndDownloadWidget extends StatelessWidget {
  const PodcastDurationAndDownloadWidget({
    super.key,
    required this.podcastDurathion,
    required this.podcastEntitie,
    required this.podcastCardCallBacksParams,
  });

  final double podcastDurathion;
  final BasePodcastEntitie podcastEntitie;
  final PodcastCardCallBacksParams podcastCardCallBacksParams;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Row(
        children: [
          Text(
            covertDurationTime(podcastDurathion),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          podcastEntitie.podcastId == currentDownloadingPodcastId
              ? StreamBuilder<double>(
                  stream: downloadProgress.stream,
                  builder: (context, snapshot) => CircularProgressIndicator(
                        value: snapshot.data,
                      ))
              : IconButton(
                  onPressed: podcastCardCallBacksParams.onPressedDownload,
                  icon: const Icon(Icons.downloading_outlined)),
        ],
      ),
    );
  }
}
