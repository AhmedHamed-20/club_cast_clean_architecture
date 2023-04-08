// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/features/Search/domain/entities/podcast_search_information_entity.dart';

abstract class PodcastSearchEntity extends Equatable {
  final int results;
  final List<PodcastSearchInformationDataEntity> podcastInformationEntitie;
  const PodcastSearchEntity({
    required this.results,
    required this.podcastInformationEntitie,
  });

  PodcastSearchEntity copyWith({
    int? results,
    List<PodcastSearchInformationDataEntity>? podcastInformationEntitie,
  });
  Map<String, dynamic> toJson();
}
