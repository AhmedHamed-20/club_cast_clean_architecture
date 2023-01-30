import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import '../../constants/base_podcast_entitie/base_podcast_entitie.dart';
import '../../constants/constants.dart';
import '../../constants/params.dart';
import '../cached_network_image_circle_photo.dart';

class PodcastCardBottomRowWidget extends StatelessWidget {
  const PodcastCardBottomRowWidget({
    super.key,
    required this.podcastEntitie,
    required this.podcastCardCallBacksParams,
  });

  final BasePodcastEntitie podcastEntitie;
  final PodcastCardCallBacksParams podcastCardCallBacksParams;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: podcastCardCallBacksParams.onPressedOnUserPhoto,
          child: CachedNetworkImageCirclePhoto(
            photoUrl: podcastEntitie.podcastUserInfo.userImage,
            photoRadius: 50,
          ),
        ),
        SizedBox(
          width: AppWidth.w6,
        ),
        Text(
          podcastEntitie.podcastUserInfo.userName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.background,
              ),
        ),
        const Spacer(),
        InkWell(
          onTap: podcastCardCallBacksParams.onPressedOnLikesCount,
          child: CircleAvatar(
            radius: AppRadius.r16,
            backgroundColor: Theme.of(context).colorScheme.background,
            child: Text(
              podcastEntitie.podcastLikesCount.toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        BlocBuilder<CommonPlayingPodcastBlocBloc,
            CommonPlayingPodcastBlocState>(builder: (context, state) {
          if ((state.podcastsLikesStatus != null &&
                  state.podcastsLikesStatus!.isNotEmpty) &&
              state.podcastsLikesStatus!
                  .containsKey(podcastEntitie.podcastId)) {
            return IconButton(
              onPressed: podcastCardCallBacksParams.onPressedOnLikeButton,
              icon: Icon(
                state.podcastsLikesStatus![podcastEntitie.podcastId] == true
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Theme.of(context).colorScheme.background,
              ),
            );
          } else {
            return IconButton(
              onPressed: podcastCardCallBacksParams.onPressedOnLikeButton,
              icon: Icon(
                podcastEntitie.isLiked ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.background,
              ),
            );
          }
        }),
      ],
    );
  }
}
