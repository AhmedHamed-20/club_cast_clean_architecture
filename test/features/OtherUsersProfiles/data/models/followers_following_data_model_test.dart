import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/followers_following_data_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/remote_other_users_dumy_data.dart';

void main() {
  group('test followers following data model', () {
    test('followers following data model to json test', () {
      expect(tOtherUserFollowersFollowingDataModel.toJson(true), isA<Map>());
      expect(tOtherUserFollowersFollowingDataModel.toJson(false), isA<Map>());
    });
    test(
        'followers following basic data model from json test if from json take true as paremater for is follower',
        () {
      final OtherUserFollowersFollowingDataModel
          otherUserFollowersFollowingDataModel =
          OtherUserFollowersFollowingDataModel.fromJson(
              tOtherUserFollowersFollowingDataModel.toJson(true), true);
      expect(otherUserFollowersFollowingDataModel,
          isA<OtherUserFollowersFollowingDataModel>());
      expect(tOtherUserFollowersFollowingDataModel.results, isA<int>());
      expect(
          tOtherUserFollowersFollowingDataModel
              .otherUserFollowersFollowingUserDataEntitie,
          isA<List>());
    });
    test(
        'followers following basic data model from json test if from json take false as paremater for is follower',
        () {
      final OtherUserFollowersFollowingDataModel
          otherUserFollowersFollowingDataModel =
          OtherUserFollowersFollowingDataModel.fromJson(
              tOtherUserFollowersFollowingDataModel.toJson(false), false);
      expect(otherUserFollowersFollowingDataModel,
          isA<OtherUserFollowersFollowingDataModel>());
      expect(tOtherUserFollowersFollowingDataModel.results, isA<int>());
      expect(
          tOtherUserFollowersFollowingDataModel
              .otherUserFollowersFollowingUserDataEntitie,
          isA<List>());
    });
  });
}
