import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/remote_other_users_dumy_data.dart';

void main() {
  group('test other user podcast model', () {
    test('other user podcast model to json test', () {
      expect(tOtherUserPodcastModel.toJson(), isA<Map>());
    });
    test('other user events data model from json test', () {
      final OtherUserPodcastModel otherUserPodcastModel =
          OtherUserPodcastModel.fromJson(tOtherUserPodcastModel.toJson());
      expect(otherUserPodcastModel, isA<OtherUserPodcastModel>());
      expect(otherUserPodcastModel.results, isA<int>());
      expect(otherUserPodcastModel.otherUserPodcastDataEntitie, isA<List>());
    });
  });
}
