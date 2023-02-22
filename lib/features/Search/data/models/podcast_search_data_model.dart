import 'package:club_cast_clean_architecture/features/Search/data/models/podcast_audio_info_model.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/podcast_search_user_info_model.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/podcast_search_information_entitie.dart';

class PodcastSearchDataModel extends PodcastSearchInformationDataEntitie {
  const PodcastSearchDataModel(
      {required super.podcastId,
      required super.podcastName,
      required super.podcastLikesCount,
      required super.category,
      required super.createdAt,
      required super.isLiked,
      required super.podcastUserInfo,
      required super.podcastInfo});

  factory PodcastSearchDataModel.fromJson(Map<String, dynamic> json) {
    return PodcastSearchDataModel(
      isLiked: json['isLiked'],
      category: json['category'],
      createdAt: json['createdAt'],
      podcastId: json['_id'],
      podcastLikesCount: json['likes'],
      podcastName: json['name'],
      podcastUserInfo: PodcastSearchUserInfoModel.fromJson(json['createdBy']),
      podcastInfo: PodcastAudioSearchInfoModel.fromJson(json['audio']),
    );
  }
}
