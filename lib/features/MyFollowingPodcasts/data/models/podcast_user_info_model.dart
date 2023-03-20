import '../../../../core/constants/base_podcast_entitie/base_podcast_userinfo_entity.dart';

class PodcastUserInfoModel extends PodcastUserInfoEntity {
  const PodcastUserInfoModel(super.userName, super.userImage, super.userId);

  factory PodcastUserInfoModel.fromJson(Map<String, dynamic> json) {
    return PodcastUserInfoModel(json['name'], json['photo'], json['_id']);
  }
}
