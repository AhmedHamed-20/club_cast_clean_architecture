import 'package:club_cast_clean_architecture/features/Podcast/domain/entities/podcast_audio_info_entitie.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/entities/podcast_user_info_entitie.dart';
import 'package:equatable/equatable.dart';

class PodcastEntitie extends Equatable {
  final String podcastId;
  final String podcastName;
  final int podcastLikesCount;
  final String category;
  final String createdAt;
  final bool isLiked;
  final PodcastUserInfoEntitie podcastUserInfo;
  final PodcastAudioInoEntitie podcastInfo;

  const PodcastEntitie(
      {required this.podcastId,
      required this.isLiked,
      required this.podcastName,
      required this.podcastLikesCount,
      required this.category,
      required this.createdAt,
      required this.podcastUserInfo,
      required this.podcastInfo});

  @override
  List<Object?> get props => [
        podcastId,
        isLiked,
        podcastName,
        podcastLikesCount,
        category,
        createdAt,
        podcastUserInfo,
        podcastInfo
      ];
}
