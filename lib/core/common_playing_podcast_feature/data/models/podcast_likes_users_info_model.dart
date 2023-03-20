import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/models/podcast_user_info_model.dart';

import '../../domain/entities/podcast_likes_users_entity.dart';

class PodcastLikesUsersInfoModel extends PodcastLikesUsersInfoEntity {
  const PodcastLikesUsersInfoModel(
      {required super.createdAt, required super.podcastUserInfoEntity});

  factory PodcastLikesUsersInfoModel.fromJson(Map<String, dynamic> json) {
    return PodcastLikesUsersInfoModel(
        createdAt: json['createdAt'],
        podcastUserInfoEntity: PodcastUserInfoModel.fromJson(json['user']));
  }
}
