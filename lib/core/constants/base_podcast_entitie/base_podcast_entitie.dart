import 'package:equatable/equatable.dart';

import 'base_podcast_audio_info.dart';
import 'base_podcast_userinfo_entite.dart';

abstract class BasePodcastEntitie extends Equatable {
  final String podcastId;
  final String podcastName;
  final int podcastLikesCount;
  final String category;
  final String createdAt;
  final bool isLiked;
  final PodcastUserInfoEntitie podcastUserInfo;
  final PodcastAudioInoEntitie podcastInfo;

  const BasePodcastEntitie(
      {required this.podcastId,
      required this.podcastName,
      required this.podcastLikesCount,
      required this.category,
      required this.createdAt,
      required this.isLiked,
      required this.podcastUserInfo,
      required this.podcastInfo});
}
