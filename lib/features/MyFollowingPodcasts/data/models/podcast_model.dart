import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/models/podcast_information_model.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entitie.dart';

class PodcastModel extends MyFollowingPodcastEntitie {
  const PodcastModel(
      {required super.results, required super.podcastInformationEntitie});

  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    return PodcastModel(
        results: json['results'],
        podcastInformationEntitie: (json['data'] as List)
            .map((e) => PodcastInformationModel.fromJson(e))
            .toList());
  }
}
