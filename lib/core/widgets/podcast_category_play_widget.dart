import 'package:flutter/material.dart';

import '../constants/base_podcast_entitie/base_podcast_entitie.dart';
import '../constants/constants.dart';
import '../constants/params.dart';

class PodcastCategoryAndPlayWidget extends StatelessWidget {
  const PodcastCategoryAndPlayWidget({
    super.key,
    required this.podcastEntitie,
    required this.isMyProfile,
    required this.podcastCardCallBacksParams,
  });

  final BasePodcastEntitie podcastEntitie;
  final bool? isMyProfile;
  final PodcastCardCallBacksParams podcastCardCallBacksParams;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            podcastEntitie.category,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (isMyProfile != null && isMyProfile == true)
            CircleAvatar(
              radius: AppRadius.r22,
              backgroundColor: Theme.of(context).primaryColor,
              child: IconButton(
                onPressed: podcastCardCallBacksParams.onPressedPlay,
                icon: Center(
                  child: Icon(
                    currentPlayingPodcastsId == podcastEntitie.podcastId
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
