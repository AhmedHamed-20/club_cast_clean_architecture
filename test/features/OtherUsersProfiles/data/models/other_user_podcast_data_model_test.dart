import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_data_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_info_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_user_info.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/remote_other_users_dumy_data.dart';

void main() {
  group('test other user events model', () {
    test('other user podcast data model to json test', () {
      expect(tOtherUserPodcastDataModel.toJson(), isA<Map>());
    });
    test('other user events data model from json test', () {
      final OtherUserPodcastDataModel otherUserPodcastDataModel =
          OtherUserPodcastDataModel.fromJson(
              tOtherUserPodcastDataModel.toJson());
      expect(otherUserPodcastDataModel, isA<OtherUserPodcastDataModel>());
      expect(otherUserPodcastDataModel.category, isA<String>());
      expect(otherUserPodcastDataModel.createdAt, isA<String>());
      expect(otherUserPodcastDataModel.podcastId, isA<String>());
      expect(otherUserPodcastDataModel.podcastLikesCount, isA<int>());
      expect(otherUserPodcastDataModel.podcastName, isA<String>());
      expect(otherUserPodcastDataModel.podcastUserInfo,
          isA<OtherUserPodcastUserInfoModel>());
      expect(otherUserPodcastDataModel.podcastInfo,
          isA<OtherUserPodcastAudioInfoModel>());
      expect(otherUserPodcastDataModel.isLiked, isA<bool>());
    });
  });
}
