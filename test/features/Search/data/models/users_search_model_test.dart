import 'package:club_cast_clean_architecture/features/Search/data/models/users_search_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/remote_search_data_source_dumy_data.dart';

void main() {
  group('users_search_model test', () {
    test('test users_search_model to json', () {
      final Map<String, dynamic> usersSearchMap = tSearchUsersModel.toJson();
      expect(usersSearchMap, isA<Map<String, dynamic>>());
    });
    test('test users_search_model from json', () {
      final Map<String, dynamic> userSearchMap = tSearchUsersModel.toJson();
      final SearchUsersModel usersSearchModel =
          SearchUsersModel.fromJson(userSearchMap);
      expect(usersSearchModel, isA<SearchUsersModel>());
      expect(usersSearchModel.userId, isA<String>());
      expect(usersSearchModel.userPhoto, isA<String>());
      expect(usersSearchModel.userName, isA<String>());
      expect(usersSearchModel.isFollowed, isA<bool>());
    });
  });
}
