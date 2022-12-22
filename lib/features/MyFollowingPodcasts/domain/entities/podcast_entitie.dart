import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_information_entitie.dart';
import 'package:equatable/equatable.dart';

class PodcastEntitie extends Equatable {
  final int results;
  final List<PodcastInformationEntitie> podcastInformationEntitie;
  const PodcastEntitie({
    required this.results,
    required this.podcastInformationEntitie,
  });

  @override
  List<Object?> get props => [
        podcastInformationEntitie,
        results,
      ];
}
