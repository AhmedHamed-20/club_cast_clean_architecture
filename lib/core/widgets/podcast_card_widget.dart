import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';

class PodcastCardWidget extends StatelessWidget {
  const PodcastCardWidget(
      {super.key,
      required this.isLiked,
      required this.podcastDurathion,
      required this.podcastLikes,
      required this.podcastName,
      required this.onPressedOnCard,
      required this.onPressedOnUserPhoto,
      required this.onPressedOnLikeButton,
      required this.podcastPhoto,
      required this.podcastUserName,
      required this.onPressedDownload,
      required this.onPressedPlay,
      required this.podcastId,
      required this.onPressedOnLikesCount,
      this.isMyProfile,
      this.onPressedOnRemove});
  final VoidCallback? onPressedOnRemove;
  final String podcastName;
  final String podcastPhoto;
  final String podcastUserName;
  final String podcastId;
  final int podcastLikes;
  final bool isLiked;
  final VoidCallback onPressedOnLikeButton;
  final VoidCallback onPressedOnCard;
  final VoidCallback onPressedOnUserPhoto;
  final double podcastDurathion;
  final VoidCallback onPressedDownload;
  final VoidCallback onPressedPlay;
  final VoidCallback onPressedOnLikesCount;
  final bool? isMyProfile;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressedOnCard,
      child: Card(
        color: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppRadius.r22,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: onPressedOnUserPhoto,
                    child: CircleAvatar(
                      radius: AppRadius.r30,
                      backgroundImage: NetworkImage(podcastPhoto),
                    ),
                  ),
                  const SizedBox(
                    width: AppWidth.w20,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          podcastName,
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          podcastUserName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          covertDurationTime(podcastDurathion),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          height: AppHeight.h10,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: onPressedPlay,
                              icon: Icon(
                                currentPlayingPodcastsId == podcastId
                                    ? Icons.pause_circle_outline
                                    : Icons.play_circle_outline,
                              ),
                            ),
                            podcastId == currentDownloadingPodcastId
                                ? StreamBuilder<double>(
                                    stream: downloadProgress.stream,
                                    builder: (context, snapshot) =>
                                        CircularProgressIndicator(
                                          value: snapshot.data,
                                        ))
                                : IconButton(
                                    onPressed: onPressedDownload,
                                    icon:
                                        const Icon(Icons.downloading_outlined)),
                          ],
                        )
                      ],
                    ),
                  ),
                  if (isMyProfile != null && isMyProfile == true)
                    const Spacer(),
                  if (isMyProfile != null && isMyProfile == true)
                    IconButton(
                        onPressed: onPressedOnRemove,
                        icon: const Icon(Icons.clear))
                ],
              ),
              const SizedBox(
                height: AppHeight.h10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: onPressedOnLikesCount,
                    child: CircleAvatar(
                      radius: AppRadius.r16,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        podcastLikes.toString(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onPressedOnLikeButton,
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_outline,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
