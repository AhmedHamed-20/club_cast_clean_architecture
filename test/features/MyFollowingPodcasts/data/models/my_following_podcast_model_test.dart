import 'package:flutter_test/flutter_test.dart';

import '../datasources/podcast_remote_data_source_dumy_data.dart';

void main() {
  group('test my following podcast model', () {
    test('test my following podcast from json', () {
      expect(tMyFollowingPodcastModel.results, isA<int>());
      expect(tMyFollowingPodcastModel.podcastInformationEntitie, isA<List>());
    });
    test('test my following podcast to json', () {
      expect(tMyFollowingPodcastModel.toJson(), isA<Map<String, dynamic>>());
    });
  });
}
