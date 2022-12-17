import 'package:club_cast_clean_architecture/features/Podcast/data/models/podcast_user_info_model.dart';

import '../../domain/entities/podcast_likes_users_entitie.dart';

class PodcastLikesUsersInfoModel extends PodcastLikesUsersInfoEntitie {
  const PodcastLikesUsersInfoModel(
      {required super.createdAt, required super.podcastUserInfoEntitie});

  factory PodcastLikesUsersInfoModel.fromJson(Map<String, dynamic> json) {
    return PodcastLikesUsersInfoModel(
        createdAt: json['createdAt'],
        podcastUserInfoEntitie: PodcastUserInfoModel.fromJson(json['user']));
  }
}
