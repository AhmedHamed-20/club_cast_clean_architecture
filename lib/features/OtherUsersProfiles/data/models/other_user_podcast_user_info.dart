import '../../../../core/constants/base_podcast_entitie/base_podcast_userinfo_entity.dart';

class OtherUserPodcastUserInfo extends PodcastUserInfoEntity {
  const OtherUserPodcastUserInfo(super.userName, super.userImage, super.userId);

  factory OtherUserPodcastUserInfo.fromJson(Map<String, dynamic> json) {
    return OtherUserPodcastUserInfo(json['name'], json['photo'], json['_id']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'name': userName, 'photo': userImage, '_id': userId};
  }

  @override
  List<Object?> get props => [userName, userImage, userId];
}
