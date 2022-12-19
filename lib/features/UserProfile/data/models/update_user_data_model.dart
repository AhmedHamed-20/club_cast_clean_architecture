import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/updated_user_data_info.dart';

class UpdatedUserDataInfoModel extends UpdatedUserDataInfoEntitie {
  const UpdatedUserDataInfoModel(
      {required super.userName,
      required super.userPhoto,
      required super.followers,
      required super.following,
      required super.uid,
      required super.email,
      required super.createdAt,
      required super.bio});

  factory UpdatedUserDataInfoModel.fromJson(Map<String, dynamic> json) {
    return UpdatedUserDataInfoModel(
      userName: json['name'],
      userPhoto: json['photo'],
      followers: json['followers'],
      following: json['following'],
      uid: json['uid'],
      email: json['email'],
      createdAt: json['createdAt'],
      bio: json['bio'],
    );
  }
}
