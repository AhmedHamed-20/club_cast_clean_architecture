import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_audio_info.dart';
import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_userinfo_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/podcast_remote_data_source_dumy_data.dart';

void main() {
  group('test my following podcast information model', () {
    test('test my following  podcast information model from json', () {
      expect(tPodcastInformationModel.category, isA<String>());
      expect(tPodcastInformationModel.createdAt, isA<String>());
      expect(tPodcastInformationModel.isLiked, isA<bool>());
      expect(tPodcastInformationModel.podcastId, isA<String>());
      expect(
          tPodcastInformationModel.podcastInfo, isA<PodcastAudioInoEntitie>());
      expect(tPodcastInformationModel.podcastLikesCount, isA<int>());
      expect(tPodcastInformationModel.podcastName, isA<String>());
      expect(tPodcastInformationModel.podcastUserInfo,
          isA<PodcastUserInfoEntity>());
    });
    test('test my following  podcast information model to json', () {
      expect(tPodcastInformationModel.toJson(), isA<Map<String, dynamic>>());
    });
  });
}
