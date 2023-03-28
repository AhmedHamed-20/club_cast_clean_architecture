import 'package:equatable/equatable.dart';

abstract class OtherUserFollowersFollowingUserDataEntity extends Equatable {
  final String uid;
  final String name;
  final String profileImage;

  const OtherUserFollowersFollowingUserDataEntity(
      {required this.uid, required this.name, required this.profileImage});

  Map<String, dynamic> toJson();
}
