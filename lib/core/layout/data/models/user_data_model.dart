import 'package:club_cast_clean_architecture/core/layout/domain/entities/user_data_entitie.dart';

class UserDataModel extends UserDataEntitie {
  const UserDataModel(
      {required super.userName,
      required super.userPhoto,
      required super.followers,
      required super.following,
      required super.uid,
      required super.createdAt,
      required super.email,
      required super.bio});

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      userName: json['name'],
      email: json['email'],
      userPhoto: json['photo'],
      followers: json['followers'],
      following: json['following'],
      uid: json['_id'],
      createdAt: json['createdAt'],
      bio: json['bio'],
    );
  }
}
