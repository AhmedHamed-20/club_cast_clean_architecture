import '../../../../core/constants/base_podcast_entitie/base_podcast_userinfo_entity.dart';

class PodcastSearchUserInfoModel extends PodcastUserInfoEntity {
  const PodcastSearchUserInfoModel(
    super.userName,
    super.userImage,
    super.userId,
  );
  factory PodcastSearchUserInfoModel.fromJson(Map<String, dynamic> json) {
    return PodcastSearchUserInfoModel(json['name'], json['photo'], json['_id']);
  }
}
