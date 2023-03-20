import 'package:club_cast_clean_architecture/features/Search/data/models/podcast_search_data_model.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/podcast_search_entity.dart';

class PodcastSearchModel extends PodcastSearchEntity {
  const PodcastSearchModel(
      {required super.results, required super.podcastInformationEntitie});
  factory PodcastSearchModel.fromJson(Map<String, dynamic> json) {
    return PodcastSearchModel(
        results: json['results'],
        podcastInformationEntitie: (json['data'] as List)
            .map((e) => PodcastSearchDataModel.fromJson(e))
            .toList());
  }
}
