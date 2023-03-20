import '../../domain/entities/followers_following_basic_data_entity.dart';

class OtherUserFollowersFollowingBasicDataModel
    extends OtherUserFollowersFollowingUserDataEntity {
  const OtherUserFollowersFollowingBasicDataModel(
      {required super.uid, required super.name, required super.profileImage});

  factory OtherUserFollowersFollowingBasicDataModel.fromJson(
      Map<String, dynamic> json) {
    return OtherUserFollowersFollowingBasicDataModel(
      uid: json['_id'],
      name: json['name'],
      profileImage: json['photo'],
    );
  }

  @override
  List<Object?> get props => [uid, name, profileImage];
}
