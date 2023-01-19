import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_data_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_podcast_entitie.dart';

class OtherUserPodcastModel extends OtherUserPodcastEntitie {
  const OtherUserPodcastModel(
      {required super.results, required super.otherUserPodcastDataEntitie});

  factory OtherUserPodcastModel.fromJson(Map<String, dynamic> json) {
    return OtherUserPodcastModel(
        results: json['results'],
        otherUserPodcastDataEntitie: (json['data'] as List)
            .map((e) => OtherUserPodcastDataModel.fromJson(e))
            .toList());
  }
}
