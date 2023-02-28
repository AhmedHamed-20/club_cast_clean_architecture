import 'package:club_cast_clean_architecture/features/UserProfile/data/models/my_podcast_data_model.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_entite.dart';

class MyPodcastModel extends MyPodcastEntitie {
  const MyPodcastModel(
      {required super.results, required super.myPodcastDataEntitie});

  factory MyPodcastModel.fromJson(Map<String, dynamic> json) {
    return MyPodcastModel(
      results: json['results'],
      myPodcastDataEntitie: json['data']
          .map<MyPodcastsDataModel>((e) => MyPodcastsDataModel.fromJson(e))
          .toList(),
    );
  }
}
