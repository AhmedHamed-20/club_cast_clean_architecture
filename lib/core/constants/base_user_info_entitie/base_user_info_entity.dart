import 'package:equatable/equatable.dart';

abstract class BaseUserDataEntity extends Equatable {
  final String userName;
  final String userPhoto;
  final int followers;
  final int following;
  final String id;
  final String createdAt;
  final String bio;
  final String email;

  const BaseUserDataEntity(
      {required this.userName,
      required this.userPhoto,
      required this.followers,
      required this.following,
      required this.id,
      required this.email,
      required this.createdAt,
      required this.bio});
}
