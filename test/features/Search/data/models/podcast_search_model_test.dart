import 'package:club_cast_clean_architecture/features/Search/data/models/podcast_search_model.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/podcast_search_information_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/remote_search_data_source_dumy_data.dart';

void main() {
  group('podcast_search_model test', () {
    test('test podcast_search_model to json', () {
      final Map<String, dynamic> podcastSearchMap =
          tPodcastSearchModel.toJson();
      expect(podcastSearchMap, isA<Map<String, dynamic>>());
    });
    test('test podcast_search_model from json', () {
      final Map<String, dynamic> podcastSearchMap =
          tPodcastSearchModel.toJson();
      final PodcastSearchModel podcastSearchModel =
          PodcastSearchModel.fromJson(podcastSearchMap);
      expect(podcastSearchModel, isA<PodcastSearchModel>());
      expect(podcastSearchModel.results, isA<int>());
      expect(podcastSearchModel.podcastInformationEntitie,
          isA<List<PodcastSearchInformationDataEntity>>());
    });
  });
}
