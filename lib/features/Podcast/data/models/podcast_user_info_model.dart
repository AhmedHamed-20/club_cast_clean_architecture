import 'package:club_cast_clean_architecture/features/Podcast/domain/entities/podcast_user_info_entitie.dart';

class PodcastUserInfoModel extends PodcastUserInfoEntitie {
  const PodcastUserInfoModel(super.userName, super.userImage, super.userId);

  factory PodcastUserInfoModel.fromJson(Map<String, dynamic> json) {
    return PodcastUserInfoModel(json['name'], json['photo'], json['_id']);
  }
}
