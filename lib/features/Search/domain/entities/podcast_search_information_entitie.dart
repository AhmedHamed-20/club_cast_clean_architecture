import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_entitie.dart';

class PodcastSearchInformationDataEntitie extends BasePodcastEntitie {
  const PodcastSearchInformationDataEntitie(
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
        podcastId,
        isLiked,
        podcastName,
        podcastLikesCount,
        category,
        createdAt,
        podcastUserInfo,
        podcastInfo,
      ];
}
