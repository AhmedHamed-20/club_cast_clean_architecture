import 'package:club_cast_clean_architecture/core/constants/base_room_user_data_entity/base_room_user_data_entity.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/rooms__search_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/remote_search_data_source_dumy_data.dart';

void main() {
  group('rooms_search_model test', () {
    test('test rooms_search_model to json', () {
      final Map<String, dynamic> roomsSearchMap = tSearchRoomsModel.toJson();
      expect(roomsSearchMap, isA<Map<String, dynamic>>());
    });
    test('test rooms_search_model from json', () {
      final Map<String, dynamic> roomsSearchMap = tSearchRoomsModel.toJson();
      final SearchRoomsModel roomsSearchModel =
          SearchRoomsModel.fromJson(roomsSearchMap);
      expect(roomsSearchModel, isA<SearchRoomsModel>());
      expect(roomsSearchModel.category, isA<String>());
      expect(roomsSearchModel.createdAt, isA<String>());
      expect(roomsSearchModel.id, isA<String>());
      expect(roomsSearchModel.isRecording, isA<bool>());
      expect(roomsSearchModel.name, isA<String>());
      expect(roomsSearchModel.admin, isA<BaseRoomUserDataEntity>());
      expect(roomsSearchModel.audience, isA<List<BaseRoomUserDataEntity>>());
      expect(roomsSearchModel.brodcasters, isA<List<BaseRoomUserDataEntity>>());
    });
  });
}
