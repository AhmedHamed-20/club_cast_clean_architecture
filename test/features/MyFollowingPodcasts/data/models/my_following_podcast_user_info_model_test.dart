import 'package:flutter_test/flutter_test.dart';

import '../datasources/podcast_remote_data_source_dumy_data.dart';

void main() {
  group('test my following podcast user info model', () {
    test('test my following podcast user info from json', () {
      expect(tPodcastUserInfoModel.userId, isA<String>());
      expect(tPodcastUserInfoModel.userName, isA<String>());
      expect(tPodcastUserInfoModel.userImage, isA<String>());
    });
    test('test my following podcast user info to json', () {
      expect(tPodcastUserInfoModel.toJson(), isA<Map<String, dynamic>>());
    });
  });
}
