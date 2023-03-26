import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/models/my_following_podcast_audio_info_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test my following  podcast audio info model', () {
    final podcastAudioInfoModel = PodcastAudioInfoModel.fromJson(const {
      'duration': 1.0,
      'url': 'url',
    });
    test('test my following  podcast audio info model from json', () async {
      expect(podcastAudioInfoModel.podcastDuration, isA<double>());
      expect(podcastAudioInfoModel.podcastUrl, isA<String>());
    });
    test('test my following  podcast audio info model to json', () {
      expect(podcastAudioInfoModel.toJson(), isA<Map<String, dynamic>>());
    });
  });
}
