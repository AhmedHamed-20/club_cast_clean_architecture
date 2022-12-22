import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';

class PodcastCardWidget extends StatelessWidget {
  const PodcastCardWidget({
    super.key,
    required this.isLiked,
    required this.podcastDurathion,
    required this.podcastLikes,
    required this.podcastName,
    required this.onPressedOnCard,
    required this.onPressedOnUserPhoto,
    required this.onPressedOnLikeButton,
    required this.podcastPhoto,
    required this.podcastUserName,
  });
  final String podcastName;
  final String podcastPhoto;
  final String podcastUserName;
  final int podcastLikes;
  final bool isLiked;
  final VoidCallback onPressedOnLikeButton;
  final VoidCallback onPressedOnCard;
  final VoidCallback onPressedOnUserPhoto;
  final double podcastDurathion;
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        podcastName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        podcastUserName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        covertDurationTime(podcastDurathion),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: AppHeight.h10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: AppRadius.r16,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      podcastLikes.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
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
