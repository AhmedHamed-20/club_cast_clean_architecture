import 'package:club_cast_clean_architecture/features/Search/data/models/podcast_audio_info_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/remote_search_data_source_dumy_data.dart';

void main() {
  group('podcast_search_audio_info_model test', () {
    test('test podcast_search_audio_info_model to json', () {
      final Map<String, dynamic> podcastSearchAudioInfoMap =
          tPodcastSearchAudioInfoModel.toJson();
      expect(podcastSearchAudioInfoMap, isA<Map<String, dynamic>>());
    });
    test('test podcast_search_audio_info_model from json', () {
      final Map<String, dynamic> podcastSearchAudioInfoMap =
          tPodcastSearchAudioInfoModel.toJson();
      final PodcastAudioSearchInfoModel podcastSearchAudioInfoModel =
          PodcastAudioSearchInfoModel.fromJson(podcastSearchAudioInfoMap);
      expect(podcastSearchAudioInfoModel, isA<PodcastAudioSearchInfoModel>());
      expect(podcastSearchAudioInfoModel.podcastDuration, isA<double>());
      expect(podcastSearchAudioInfoModel.podcastUrl, isA<String>());
    });
  });
}
