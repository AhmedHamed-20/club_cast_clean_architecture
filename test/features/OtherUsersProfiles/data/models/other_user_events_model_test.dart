import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_events_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/remote_other_users_dumy_data.dart';

void main() {
  group('test other user events model', () {
    test('other user events data to json test', () {
      expect(tOtherUserEventsModel.toJson(), isA<Map>());
    });
    test('other user events data model from json test', () {
      final OtherUserEventsModel otherUserEventsModel =
          OtherUserEventsModel.fromJson(tOtherUserEventsModel.toJson());
      expect(otherUserEventsModel, isA<OtherUserEventsModel>());
      expect(otherUserEventsModel.results, isA<int>());
      expect(otherUserEventsModel.events, isA<List>());
    });
  });
}
