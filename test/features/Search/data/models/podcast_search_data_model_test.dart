import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_audio_info.dart';
import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_userinfo_entity.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/podcast_search_data_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/remote_search_data_source_dumy_data.dart';

void main() {
  group('podcast_search_audio_info_model test', () {
    test('test podcast_search_data_model to json', () {
      final Map<String, dynamic> podcastSearchDataMap =
          tPodcastSearchDataModel.toJson();
      expect(podcastSearchDataMap, isA<Map<String, dynamic>>());
    });
    test('test podcast_search_audio_info_model from json', () {
      final Map<String, dynamic> podcastSearchDataMap =
          tPodcastSearchDataModel.toJson();
      final PodcastSearchDataModel podcastSearchDataModel =
          PodcastSearchDataModel.fromJson(podcastSearchDataMap);
      expect(podcastSearchDataModel, isA<PodcastSearchDataModel>());
      expect(podcastSearchDataModel.category, isA<String>());
      expect(podcastSearchDataModel.createdAt, isA<String>());
      expect(podcastSearchDataModel.isLiked, isA<bool>());
      expect(podcastSearchDataModel.podcastId, isA<String>());
      expect(podcastSearchDataModel.podcastInfo, isA<PodcastAudioInoEntitie>());
      expect(podcastSearchDataModel.podcastName, isA<String>());
      expect(
          podcastSearchDataModel.podcastUserInfo, isA<PodcastUserInfoEntity>());
    });
  });
}
