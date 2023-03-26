import 'package:equatable/equatable.dart';

abstract class PodcastUserInfoEntity extends Equatable {
  final String userName;
  final String userImage;
  final String userId;

  const PodcastUserInfoEntity(this.userName, this.userImage, this.userId);

  Map<String, dynamic> toJson();
}
