import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/models/my_following_podcast_information_model.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entity.dart';

class MyFollowingPodcastModel extends MyFollowingPodcastEntity {
  const MyFollowingPodcastModel(
      {required super.results, required super.podcastInformationEntitie});

  factory MyFollowingPodcastModel.fromJson(Map<String, dynamic> json) {
    return MyFollowingPodcastModel(
        results: json['results'],
        podcastInformationEntitie: (json['data'] as List)
            .map((e) => PodcastInformationModel.fromJson(e))
            .toList());
  }
  Map<String, dynamic> toJson() {
    return {
      'results': results,
      'data': podcastInformationEntitie.map((e) => e.toJson()).toList()
    };
  }
}
