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
}
