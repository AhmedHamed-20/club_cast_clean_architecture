import '../../../../core/constants/base_podcast_entitie/base_podcast_userinfo_entite.dart';

class PodcastUserInfoModel extends PodcastUserInfoEntitie {
  const PodcastUserInfoModel(super.userName, super.userImage, super.userId);

  factory PodcastUserInfoModel.fromJson(Map<String, dynamic> json) {
    return PodcastUserInfoModel(json['name'], json['photo'], json['_id']);
  }
}
