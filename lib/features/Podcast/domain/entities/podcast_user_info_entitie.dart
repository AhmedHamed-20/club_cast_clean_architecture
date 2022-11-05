import 'package:equatable/equatable.dart';

class PodcastUserInfoEntitie extends Equatable {
  final String userName;
  final String userImage;
  final String userId;

  const PodcastUserInfoEntitie(this.userName, this.userImage, this.userId);

  @override
  List<Object?> get props => [userName, userImage, userId];
}
