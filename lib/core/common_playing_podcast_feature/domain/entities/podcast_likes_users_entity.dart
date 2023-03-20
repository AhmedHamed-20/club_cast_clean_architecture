import 'package:equatable/equatable.dart';

import '../../../constants/base_podcast_entitie/base_podcast_userinfo_entity.dart';

class PodcastLikesUsersInfoEntity extends Equatable {
  final String createdAt;
  final PodcastUserInfoEntity podcastUserInfoEntity;

  const PodcastLikesUsersInfoEntity(
      {required this.createdAt, required this.podcastUserInfoEntity});
  @override
  List<Object?> get props => [createdAt, podcastUserInfoEntity];
}
