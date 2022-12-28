import 'package:equatable/equatable.dart';

import '../../../constants/base_podcast_entitie/base_podcast_userinfo_entite.dart';

class PodcastLikesUsersInfoEntitie extends Equatable {
  final String createdAt;
  final PodcastUserInfoEntitie podcastUserInfoEntitie;

  const PodcastLikesUsersInfoEntitie(
      {required this.createdAt, required this.podcastUserInfoEntitie});
  @override
  List<Object?> get props => [createdAt, podcastUserInfoEntitie];
}
