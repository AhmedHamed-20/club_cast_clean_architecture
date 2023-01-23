import 'package:cached_network_image/cached_network_image.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    child: CachedNetworkImage(
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/noImage.jpg'),
                      imageUrl: podcastPhoto,
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
                  BlocBuilder<CommonPlayingPodcastBlocBloc,
                      CommonPlayingPodcastBlocState>(builder: (context, state) {
                    if ((state.podcastsLikesStatus != null &&
                            state.podcastsLikesStatus!.isNotEmpty) &&
                        state.podcastsLikesStatus!.containsKey(podcastId)) {
                      return IconButton(
                        onPressed: onPressedOnLikeButton,
                        icon: Icon(
                          state.podcastsLikesStatus![podcastId] == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    } else {
                      return IconButton(
                        onPressed: onPressedOnLikeButton,
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    }
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
