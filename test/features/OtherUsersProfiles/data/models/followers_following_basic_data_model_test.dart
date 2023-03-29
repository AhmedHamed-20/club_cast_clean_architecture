import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/followers_following_basic_data_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/remote_other_users_dumy_data.dart';

void main() {
  group('test followers following basic data model', () {
    test('followers following basic data model to json test', () {
      expect(tOtherUserFollowersFollowingBasicDataModel.toJson(), isA<Map>());
    });
    test('followers following basic data model from json test', () {
      final OtherUserFollowersFollowingBasicDataModel
          otherUserFollowersFollowingBasicDataModel =
          OtherUserFollowersFollowingBasicDataModel.fromJson(
              tOtherUserFollowersFollowingBasicDataModel.toJson());
      expect(otherUserFollowersFollowingBasicDataModel,
          isA<OtherUserFollowersFollowingBasicDataModel>());
      expect(otherUserFollowersFollowingBasicDataModel.name, isA<String>());
      expect(otherUserFollowersFollowingBasicDataModel.profileImage,
          isA<String>());
      expect(otherUserFollowersFollowingBasicDataModel.uid, isA<String>());
    });
  });
}
