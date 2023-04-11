import 'package:club_cast_clean_architecture/features/Search/data/models/podcast_search_user_info_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/remote_search_data_source_dumy_data.dart';

void main() {
  group('podcast_search_user_info_model test', () {
    test('test podcast_search_user_info_ to json', () {
      final Map<String, dynamic> podcastSearchUserInfoMap =
          tPodcastSearchUserInfoModel.toJson();
      expect(podcastSearchUserInfoMap, isA<Map<String, dynamic>>());
    });
    test('test podcast_search_user_info_ from json', () {
      final Map<String, dynamic> podcastSearchUserInfoMap =
          tPodcastSearchUserInfoModel.toJson();
      final PodcastSearchUserInfoModel podcastSearchUserInfoModel =
          PodcastSearchUserInfoModel.fromJson(podcastSearchUserInfoMap);
      expect(podcastSearchUserInfoModel, isA<PodcastSearchUserInfoModel>());
      expect(podcastSearchUserInfoModel.userId, isA<String>());
      expect(podcastSearchUserInfoModel.userImage, isA<String>());
      expect(podcastSearchUserInfoModel.userName, isA<String>());
    });
  });
}
