import '../../domain/entities/other_users_data_entitie.dart';

class OtherUserDataModel extends OtherUserDataEntitie {
  const OtherUserDataModel(
      {required super.userName,
      required super.userPhoto,
      required super.followers,
      required super.following,
      required super.id,
      required super.email,
      required super.isFollowing,
      required super.createdAt,
      required super.bio});

  factory OtherUserDataModel.fromJson(Map<String, dynamic> json) {
    return OtherUserDataModel(
        userName: json['name'],
        userPhoto: json['photo'],
        followers: json['followers'],
        following: json['following'],
        id: json['_id'],
        isFollowing: json['isFollowed'],
        email: json['email'] ?? '',
        createdAt: json['createdAt'],
        bio: json['bio']);
  }

  @override
  List<Object?> get props => [
        userName,
        userPhoto,
        followers,
        following,
        id,
        email,
        createdAt,
        bio,
        isFollowing
      ];
}
