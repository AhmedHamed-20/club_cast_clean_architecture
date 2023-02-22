import '../../../../core/constants/base_podcast_entitie/base_podcast_userinfo_entite.dart';

class PodcastSearchUserInfoModel extends PodcastUserInfoEntitie {
  const PodcastSearchUserInfoModel(
    super.userName,
    super.userImage,
    super.userId,
  );
  factory PodcastSearchUserInfoModel.fromJson(Map<String, dynamic> json) {
    return PodcastSearchUserInfoModel(json['name'], json['photo'], json['_id']);
  }
}
