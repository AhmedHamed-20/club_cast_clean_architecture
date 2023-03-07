import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_entitie.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/podcast_card_widgets/podcast_bottom_row_card_widget.dart';
import 'package:club_cast_clean_architecture/core/widgets/podcast_card_widgets/podcast_card_name_play_or_remove_widget.dart';
import 'package:club_cast_clean_architecture/core/widgets/podcast_card_widgets/podcast_card_widget_duration_download_widget.dart';
import 'package:club_cast_clean_architecture/core/widgets/podcast_card_widgets/podcast_category_play_widget.dart';
import 'package:flutter/material.dart';

import '../../constants/params.dart';

class PodcastCardWidget extends StatelessWidget {
  const PodcastCardWidget({
    super.key,
    required this.podcastDurathion,
    required this.podcastEntitie,
    required this.podcastCardCallBacksParams,
    required this.onPressedOnLike,
    this.isMyProfile,
  });
  final double podcastDurathion;
  final BasePodcastEntitie podcastEntitie;
  final PodcastCardCallBacksParams podcastCardCallBacksParams;
  final VoidCallback onPressedOnLike;
  final bool? isMyProfile;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: podcastCardCallBacksParams.onPressedOnCard,
      child: Card(
        elevation: AppElevation.eL4,
        color: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppRadius.r22,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PodcastCardNameAndPlayOrRemoveWidget(
                podcastEntitie: podcastEntitie,
                isMyProfile: isMyProfile,
                podcastCardCallBacksParams: podcastCardCallBacksParams),
            PodcastCategoryAndPlayWidget(
                podcastEntitie: podcastEntitie,
                isMyProfile: isMyProfile,
                podcastCardCallBacksParams: podcastCardCallBacksParams),
            PodcastDurationAndDownloadWidget(
                podcastDurathion: podcastDurathion,
                podcastEntitie: podcastEntitie,
                podcastCardCallBacksParams: podcastCardCallBacksParams),
            Container(
              width: double.infinity,
              height: 80,
              padding: const EdgeInsets.all(AppPadding.p12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppRadius.r22),
                  bottomRight: Radius.circular(
                    AppRadius.r22,
                  ),
                ),
              ),
              child: PodcastCardBottomRowWidget(
                  onPressedOnLike: onPressedOnLike,
                  podcastEntitie: podcastEntitie,
                  podcastCardCallBacksParams: podcastCardCallBacksParams),
            ),
          ],
        ),
      ),
    );
  }
}
