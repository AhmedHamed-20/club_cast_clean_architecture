import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_events_data_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/remote_other_users_dumy_data.dart';

void main() {
  group('test other user events data model', () {
    test('other user events data model to json test', () {
      expect(tOtherUserEventsDataModel.toJson(), isA<Map>());
    });
    test('other user events data model from json test', () {
      final OtherUserEventsDataModel otherUserEventsDataModel =
          OtherUserEventsDataModel.fromJson(tOtherUserEventsDataModel.toJson());
      expect(otherUserEventsDataModel, isA<OtherUserEventsDataModel>());
      expect(otherUserEventsDataModel.eventDate, isA<String>());
      expect(otherUserEventsDataModel.eventDescription, isA<String>());
      expect(otherUserEventsDataModel.eventId, isA<String>());
      expect(otherUserEventsDataModel.eventName, isA<String>());
    });
  });
}
