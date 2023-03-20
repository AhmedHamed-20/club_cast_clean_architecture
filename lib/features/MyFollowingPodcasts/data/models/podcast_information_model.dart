import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_userinfo_entity.dart';
import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_audio_info.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/models/podcast_audio_info_model.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/models/podcast_user_info_model.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_information_entity.dart';

class PodcastInformationModel extends PodcastInformationEntity {
  const PodcastInformationModel(
      {required super.podcastId,
      required super.podcastName,
      required super.podcastLikesCount,
      required super.category,
      required super.createdAt,
      required super.isLiked,
      required super.podcastUserInfo,
      required super.podcastInfo});
  factory PodcastInformationModel.fromJson(Map<String, dynamic> json) {
    return PodcastInformationModel(
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

  @override
  PodcastInformationEntity copyWith(
      {String? podcastId,
      String? podcastName,
      int? podcastLikesCount,
      String? category,
      String? createdAt,
      bool? isLiked,
      PodcastUserInfoEntity? podcastUserInfo,
      PodcastAudioInoEntitie? podcastInfo}) {
    return PodcastInformationModel(
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
}
