import 'package:equatable/equatable.dart';

class OtherUserFollowersFollowingUserDataEntity extends Equatable {
  final String uid;
  final String name;
  final String profileImage;

  const OtherUserFollowersFollowingUserDataEntity(
      {required this.uid, required this.name, required this.profileImage});

  @override
  List<Object?> get props => [uid, name, profileImage];
}
