import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_data_entitie.dart';

import 'my_podcast_info_model.dart';
import 'my_podcast_user_info.dart';

class MyPodcastsDataModel extends MyPodcastDataEntite {
  const MyPodcastsDataModel(
      {required super.podcastId,
      required super.podcastName,
      required super.podcastLikesCount,
      required super.category,
      required super.createdAt,
      required super.isLiked,
      required super.podcastUserInfo,
      required super.podcastInfo});

  factory MyPodcastsDataModel.fromJson(Map<String, dynamic> json) {
    return MyPodcastsDataModel(
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
