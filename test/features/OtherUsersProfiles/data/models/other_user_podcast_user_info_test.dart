import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_user_info.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/remote_other_users_dumy_data.dart';

void main() {
  group('test other user podcast user info model', () {
    test('other user podcast user info model to json test', () {
      expect(tOtherUserPodcastInfoModel.toJson(), isA<Map>());
    });
    test('other user events data model from json test', () {
      final OtherUserPodcastUserInfoModel otherUserPodcastUserInfoModel =
          OtherUserPodcastUserInfoModel.fromJson(
              tOtherUserPodcastInfoModel.toJson());
      expect(
          otherUserPodcastUserInfoModel, isA<OtherUserPodcastUserInfoModel>());
      expect(otherUserPodcastUserInfoModel.userId, isA<String>());
      expect(otherUserPodcastUserInfoModel.userImage, isA<String>());
      expect(otherUserPodcastUserInfoModel.userName, isA<String>());
    });
  });
}
