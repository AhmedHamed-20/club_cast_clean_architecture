import 'package:equatable/equatable.dart';

abstract class BaseUserDataEntitie extends Equatable {
  final String userName;
  final String userPhoto;
  final int followers;
  final int following;
  final String uid;
  final String createdAt;
  final String bio;
  final String email;

  const BaseUserDataEntitie(
      {required this.userName,
      required this.userPhoto,
      required this.followers,
      required this.following,
      required this.uid,
      required this.email,
      required this.createdAt,
      required this.bio});
}
