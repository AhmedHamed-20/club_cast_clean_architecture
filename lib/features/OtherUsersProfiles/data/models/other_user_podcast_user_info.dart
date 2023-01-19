import '../../../../core/constants/base_podcast_entitie/base_podcast_userinfo_entite.dart';

class OtherUserPodcastUserInfo extends PodcastUserInfoEntitie {
  const OtherUserPodcastUserInfo(super.userName, super.userImage, super.userId);

  factory OtherUserPodcastUserInfo.fromJson(Map<String, dynamic> json) {
    return OtherUserPodcastUserInfo(json['name'], json['photo'], json['_id']);
  }
}
