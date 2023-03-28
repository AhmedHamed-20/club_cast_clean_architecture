import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_info_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/remote_other_users_dumy_data.dart';

void main() {
  group('test other user podcast info model', () {
    test('other user podcast info model to json test', () {
      expect(tOtherUserPodcastAudioInfoModel.toJson(), isA<Map>());
    });
    test('other user events data model from json test', () {
      final OtherUserPodcastAudioInfoModel otherUserPodcastAudioInfoModel =
          OtherUserPodcastAudioInfoModel.fromJson(
              tOtherUserPodcastAudioInfoModel.toJson());
      expect(otherUserPodcastAudioInfoModel,
          isA<OtherUserPodcastAudioInfoModel>());
      expect(otherUserPodcastAudioInfoModel.podcastDuration, isA<double>());
      expect(otherUserPodcastAudioInfoModel.podcastUrl, isA<String>());
    });
  });
}
