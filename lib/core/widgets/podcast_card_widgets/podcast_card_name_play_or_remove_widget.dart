import 'package:flutter/material.dart';

import '../../constants/base_podcast_entitie/base_podcast_entitie.dart';
import '../../constants/constants.dart';
import '../../constants/params.dart';

class PodcastCardNameAndPlayOrRemoveWidget extends StatelessWidget {
  const PodcastCardNameAndPlayOrRemoveWidget({
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
        children: [
          Expanded(
            child: Text(
              podcastEntitie.podcastName,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 28),
            ),
          ),
          const Spacer(),
          isMyProfile != null && isMyProfile == true
              ? IconButton(
                  onPressed: podcastCardCallBacksParams.onPressedOnRemove,
                  icon: const Icon(Icons.clear))
              : CircleAvatar(
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
