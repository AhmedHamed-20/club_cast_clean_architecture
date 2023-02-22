import 'package:club_cast_clean_architecture/features/Search/domain/entities/podcast_search_information_entitie.dart';
import 'package:equatable/equatable.dart';

class PodcastSearchEntitie extends Equatable {
  final int results;
  final List<PodcastSearchInformationDataEntitie> podcastInformationEntitie;
  const PodcastSearchEntitie({
    required this.results,
    required this.podcastInformationEntitie,
  });

  @override
  List<Object?> get props => [
        podcastInformationEntitie,
        results,
      ];
}
