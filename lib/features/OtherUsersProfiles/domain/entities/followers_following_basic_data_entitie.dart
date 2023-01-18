import 'package:equatable/equatable.dart';

class OtherUserFollowersFollowingUserDataEntitie extends Equatable {
  final String uid;
  final String name;
  final String profileImage;

  const OtherUserFollowersFollowingUserDataEntitie(
      {required this.uid, required this.name, required this.profileImage});

  @override
  List<Object?> get props => [uid, name, profileImage];
}
