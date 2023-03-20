import 'package:equatable/equatable.dart';

abstract class BaseFollowerFollowingDataEntity extends Equatable {
  final String userName;
  final String userPhoto;
  final String userId;
  final bool isFollowed;

  const BaseFollowerFollowingDataEntity(
      {required this.userName,
      required this.userPhoto,
      required this.userId,
      required this.isFollowed});
}
