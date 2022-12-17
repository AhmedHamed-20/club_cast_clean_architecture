import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_entitie.dart';

import 'my_podcast_info_model.dart';
import 'my_podcast_user_info.dart';

class MyPodcastsModel extends MyPodcastEntite {
  const MyPodcastsModel(
      {required super.podcastId,
      required super.podcastName,
      required super.podcastLikesCount,
      required super.category,
      required super.createdAt,
      required super.isLiked,
      required super.podcastUserInfo,
      required super.podcastInfo});

  factory MyPodcastsModel.fromJson(Map<String, dynamic> json) {
    return MyPodcastsModel(
      isLiked: json['isLiked'],
      category: json['category'],
      createdAt: json['createdAt'],
      podcastId: json['_id'],
      podcastLikesCount: json['likes'],
      podcastName: json['name'],
      podcastUserInfo: MyPodcastUserInfoModel.fromJson(json['createdBy']),
      podcastInfo: MyPodcastAudioInfoModel.fromJson(json['audio']),
    );
  }
}
