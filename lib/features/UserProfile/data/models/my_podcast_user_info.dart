import '../../../../core/constants/base_podcast_entitie/base_podcast_userinfo_entite.dart';

class MyPodcastUserInfoModel extends PodcastUserInfoEntitie {
  const MyPodcastUserInfoModel(super.userName, super.userImage, super.userId);

  factory MyPodcastUserInfoModel.fromJson(Map<String, dynamic> json) {
    return MyPodcastUserInfoModel(json['name'], json['photo'], json['_id']);
  }
}
