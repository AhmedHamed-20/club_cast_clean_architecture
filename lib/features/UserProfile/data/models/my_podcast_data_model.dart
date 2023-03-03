import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_userinfo_entite.dart';
import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_audio_info.dart';
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

  @override
  MyPodcastDataEntite copyWith(
      {String? podcastId,
      String? podcastName,
      int? podcastLikesCount,
      String? category,
      String? createdAt,
      bool? isLiked,
      PodcastUserInfoEntitie? podcastUserInfo,
      PodcastAudioInoEntitie? podcastInfo}) {
    return MyPodcastsDataModel(
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
