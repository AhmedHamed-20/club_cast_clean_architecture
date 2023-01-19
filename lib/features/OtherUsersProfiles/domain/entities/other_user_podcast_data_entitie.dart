import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_entitie.dart';

class OtherUserPodcastDataEntitie extends BasePodcastEntitie {
  const OtherUserPodcastDataEntitie(
      {required super.podcastId,
      required super.podcastName,
      required super.podcastLikesCount,
      required super.category,
      required super.createdAt,
      required super.isLiked,
      required super.podcastUserInfo,
      required super.podcastInfo});

  @override
  List<Object?> get props => [
        super.podcastId,
        super.podcastName,
        super.podcastLikesCount,
        super.category,
        super.createdAt,
        super.isLiked,
        super.podcastUserInfo,
        super.podcastInfo,
      ];
}
