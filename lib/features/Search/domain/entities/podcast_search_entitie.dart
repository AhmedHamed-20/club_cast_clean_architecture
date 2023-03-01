// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/features/Search/domain/entities/podcast_search_information_entitie.dart';

class PodcastSearchEntitie extends Equatable {
  final int results;
  final List<PodcastSearchInformationDataEntitie> podcastInformationEntitie;
  const PodcastSearchEntitie({
    required this.results,
    required this.podcastInformationEntitie,
  });

  PodcastSearchEntitie copyWith({
    int? results,
    List<PodcastSearchInformationDataEntitie>? podcastInformationEntitie,
  }) {
    return PodcastSearchEntitie(
      results: results ?? this.results,
      podcastInformationEntitie:
          podcastInformationEntitie ?? this.podcastInformationEntitie,
    );
  }

  @override
  List<Object?> get props => [
        podcastInformationEntitie,
        results,
      ];
}
