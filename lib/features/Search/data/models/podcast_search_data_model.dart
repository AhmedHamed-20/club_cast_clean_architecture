import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_userinfo_entity.dart';
import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_audio_info.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/podcast_audio_info_model.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/podcast_search_user_info_model.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/podcast_search_information_entity.dart';

class PodcastSearchDataModel extends PodcastSearchInformationDataEntity {
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

  @override
  PodcastSearchInformationDataEntity copyWith(
      {String? podcastId,
      String? podcastName,
      int? podcastLikesCount,
      String? category,
      String? createdAt,
      bool? isLiked,
      PodcastUserInfoEntity? podcastUserInfo,
      PodcastAudioInoEntitie? podcastInfo}) {
    return PodcastSearchDataModel(
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

  @override
  Map<String, dynamic> toJson() {
    return {
      'isLiked': isLiked,
      'category': category,
      'createdAt': createdAt,
      '_id': podcastId,
      'likes': podcastLikesCount,
      'name': podcastName,
      'createdBy': podcastUserInfo.toJson(),
      'audio': podcastInfo.toJson(),
    };
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
