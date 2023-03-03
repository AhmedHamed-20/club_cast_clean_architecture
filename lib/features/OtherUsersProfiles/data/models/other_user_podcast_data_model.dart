import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_userinfo_entite.dart';
import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_audio_info.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_user_info.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_podcast_data_entitie.dart';

import 'other_user_podcast_info_model.dart';

class OtherUserPodcastDataModel extends OtherUserPodcastDataEntitie {
  const OtherUserPodcastDataModel(
      {required super.podcastId,
      required super.podcastName,
      required super.podcastLikesCount,
      required super.category,
      required super.createdAt,
      required super.isLiked,
      required super.podcastUserInfo,
      required super.podcastInfo});

  factory OtherUserPodcastDataModel.fromJson(Map<String, dynamic> json) {
    return OtherUserPodcastDataModel(
      isLiked: json['isLiked'],
      category: json['category'],
      createdAt: json['createdAt'],
      podcastId: json['_id'],
      podcastLikesCount: json['likes'],
      podcastName: json['name'],
      podcastUserInfo: OtherUserPodcastUserInfo.fromJson(json['createdBy']),
      podcastInfo: OtherUserPodcastAudioInfoModel.fromJson(json['audio']),
    );
  }

  @override
  OtherUserPodcastDataEntitie copyWith(
      {String? podcastId,
      String? podcastName,
      int? podcastLikesCount,
      String? category,
      String? createdAt,
      bool? isLiked,
      PodcastUserInfoEntitie? podcastUserInfo,
      PodcastAudioInoEntitie? podcastInfo}) {
    return OtherUserPodcastDataModel(
      podcastId: podcastId ?? super.podcastId,
      podcastName: podcastName ?? super.podcastName,
      podcastLikesCount: podcastLikesCount ?? super.podcastLikesCount,
      category: category ?? super.category,
      createdAt: createdAt ?? super.createdAt,
      isLiked: isLiked ?? super.isLiked,
      podcastUserInfo: podcastUserInfo ?? super.podcastUserInfo,
      podcastInfo: podcastInfo ?? super.podcastInfo,
    );
  }
}
