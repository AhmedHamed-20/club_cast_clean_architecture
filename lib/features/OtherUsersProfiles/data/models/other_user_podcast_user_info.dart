import '../../../../core/constants/base_podcast_entitie/base_podcast_userinfo_entity.dart';

class OtherUserPodcastUserInfoModel extends PodcastUserInfoEntity {
  const OtherUserPodcastUserInfoModel(
      super.userName, super.userImage, super.userId);

  factory OtherUserPodcastUserInfoModel.fromJson(Map<String, dynamic> json) {
    return OtherUserPodcastUserInfoModel(
        json['name'], json['photo'], json['_id']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'name': userName, 'photo': userImage, '_id': userId};
  }

  @override
  List<Object?> get props => [userName, userImage, userId];
}
