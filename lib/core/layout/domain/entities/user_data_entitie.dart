import 'package:equatable/equatable.dart';

class UserDataEntitie extends Equatable {
  final String userName;
  final String userPhoto;
  final int followers;
  final int following;
  final int uid;
  final String createdAt;
  final String bio;
  final String email;

  const UserDataEntitie(
      {required this.userName,
      required this.userPhoto,
      required this.followers,
      required this.following,
      required this.uid,
      required this.email,
      required this.createdAt,
      required this.bio});

  @override
  List<Object?> get props => [
        userName,
        userPhoto,
        uid,
        followers,
        following,
        email,
        createdAt,
        bio,
      ];
}
