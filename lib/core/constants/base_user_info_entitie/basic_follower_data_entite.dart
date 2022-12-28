import 'package:equatable/equatable.dart';

abstract class BaseFollowerFollowingDataEntite extends Equatable {
  final String userName;
  final String userPhoto;
  final String userId;
  final String isFollowed;

  const BaseFollowerFollowingDataEntite(
      {required this.userName,
      required this.userPhoto,
      required this.userId,
      required this.isFollowed});
}
