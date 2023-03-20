import 'package:equatable/equatable.dart';

class PodcastUserInfoEntity extends Equatable {
  final String userName;
  final String userImage;
  final String userId;

  const PodcastUserInfoEntity(this.userName, this.userImage, this.userId);

  @override
  List<Object?> get props => [userName, userImage, userId];
}
