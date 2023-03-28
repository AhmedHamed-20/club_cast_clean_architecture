import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_entitie.dart';

import '../../../../core/constants/base_podcast_entitie/base_podcast_audio_info.dart';
import '../../../../core/constants/base_podcast_entitie/base_podcast_userinfo_entity.dart';

abstract class PodcastInformationEntity extends BasePodcastEntitie {
  const PodcastInformationEntity(
      {required super.podcastId,
      required super.podcastName,
      required super.podcastLikesCount,
      required super.category,
      required super.createdAt,
      required super.isLiked,
      required super.podcastUserInfo,
      required super.podcastInfo});

  PodcastInformationEntity copyWith({
    String? podcastId,
    String? podcastName,
    int? podcastLikesCount,
    String? category,
    String? createdAt,
    bool? isLiked,
    PodcastUserInfoEntity? podcastUserInfo,
    PodcastAudioInoEntitie? podcastInfo,
  });
  Map<String, dynamic> toJson();
}
