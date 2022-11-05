import 'package:club_cast_clean_architecture/features/Podcast/domain/entities/podcast_user_info_entitie.dart';
import 'package:equatable/equatable.dart';

class PodcastLikesUsersInfoEntitie extends Equatable {
  final String createdAt;
  final PodcastUserInfoEntitie podcastUserInfoEntitie;

  const PodcastLikesUsersInfoEntitie(
      {required this.createdAt, required this.podcastUserInfoEntitie});
  @override
  List<Object?> get props => [createdAt, podcastUserInfoEntitie];
}
