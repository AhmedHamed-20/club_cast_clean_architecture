import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_entitie.dart';

import '../../../../core/constants/base_podcast_entitie/base_podcast_audio_info.dart';
import '../../../../core/constants/base_podcast_entitie/base_podcast_userinfo_entite.dart';

class MyPodcastDataEntite extends BasePodcastEntitie {
  const MyPodcastDataEntite(
      {required super.podcastId,
      required super.podcastName,
      required super.podcastLikesCount,
      required super.category,
      required super.createdAt,
      required super.isLiked,
      required super.podcastUserInfo,
      required super.podcastInfo});

  MyPodcastDataEntite copyWith({
    String? podcastId,
    String? podcastName,
    int? podcastLikesCount,
    String? category,
    String? createdAt,
    bool? isLiked,
    PodcastUserInfoEntitie? podcastUserInfo,
    PodcastAudioInoEntitie? podcastInfo,
  }) {
    return MyPodcastDataEntite(
      podcastId: podcastId ?? this.podcastId,
      podcastName: podcastName ?? this.podcastName,
      podcastLikesCount: podcastLikesCount ?? this.podcastLikesCount,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      isLiked: isLiked ?? this.isLiked,
      podcastUserInfo: podcastUserInfo ?? this.podcastUserInfo,
      podcastInfo: podcastInfo ?? this.podcastInfo,
    );
  }

  @override
  List<Object?> get props => [
        podcastId,
        podcastName,
        podcastLikesCount,
        category,
        createdAt,
        isLiked,
        podcastUserInfo,
        podcastInfo,
      ];
}
