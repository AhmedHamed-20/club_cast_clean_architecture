import 'package:club_cast_clean_architecture/features/Podcast/data/models/podcast_audio_info_model.dart';
import 'package:club_cast_clean_architecture/features/Podcast/data/models/podcast_user_info_model.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/entities/podcast_entitie.dart';

class PodcastModel extends PodcastEntitie {
  const PodcastModel(
      {required super.podcastId,
      required super.isLiked,
      required super.podcastName,
      required super.podcastLikesCount,
      required super.category,
      required super.createdAt,
      required super.podcastUserInfo,
      required super.podcastInfo});

  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    return PodcastModel(
      isLiked: json['isLiked'],
      category: json['category'],
      createdAt: json['createdAt'],
      podcastId: json['_id'],
      podcastLikesCount: json['likes'],
      podcastName: json['name'],
      podcastUserInfo: PodcastUserInfoModel.fromJson(json['createdBy']),
      podcastInfo: PodcastAudioInfoModel.fromJson(json['audio']),
    );
  }
}
