import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_users_data_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/remote_other_users_dumy_data.dart';

void main() {
  group('test other user data model', () {
    test('other user data model to json test', () {
      expect(tOtherUsersDataModel.toJson(), isA<Map>());
    });
    test('other user events data model from json test', () {
      final OtherUserDataModel otherUserDataModel =
          OtherUserDataModel.fromJson(tOtherUsersDataModel.toJson());
      expect(otherUserDataModel, isA<OtherUserDataModel>());
      expect(otherUserDataModel.isFollowing, isA<bool>());
      expect(otherUserDataModel.bio, isA<String>());
      expect(otherUserDataModel.userName, isA<String>());
      expect(otherUserDataModel.createdAt, isA<String>());
      expect(otherUserDataModel.email, isA<String>());
      expect(otherUserDataModel.id, isA<String>());
      expect(otherUserDataModel.userPhoto, isA<String>());
      expect(otherUserDataModel.followers, isA<int>());
      expect(otherUserDataModel.following, isA<int>());
    });
  });
}
