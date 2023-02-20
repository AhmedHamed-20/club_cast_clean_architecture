import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/dio.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/models/all_rooms_data_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/models/all_rooms_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/models/room_message_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/usecases/get_all_rooms.dart';
import 'package:dio/dio.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/usecases/get_room_by_room_id.dart';
import '../../domain/usecases/get_room_messages.dart';

abstract class BaseRemoteRoomsDataSource {
  Future<AllRoomsModel> getAllRooms(AllRoomsGetParams params);
  Future<AllRoomsDataModel> getRoomById(RoomGetByRoomIdParams params);

  Future<RoomMessageModel> getRoomMessage(RoomMessagesGetParams params);
}

class RemoteRoomsDataSourceImpl extends BaseRemoteRoomsDataSource {
  @override
  Future<AllRoomsModel> getAllRooms(AllRoomsGetParams params) async {
    try {
      final response = await servicelocator<DioHelper>()
          .getData(url: EndPoints.getAllRooms, headers: {
        "Authorization": "Bearer ${params.accessToken}",
      });
      return AllRoomsModel.fromJson(response?.data);
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<RoomMessageModel> getRoomMessage(RoomMessagesGetParams params) async {
    try {
      final response = await servicelocator<DioHelper>()
          .getData(url: EndPoints.getRoomMessages(params.roomId), headers: {
        "Authorization": "Bearer ${params.accessToken}",
      }, query: {
        'page': params.page
      });
      return RoomMessageModel.fromJson(response?.data);
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<AllRoomsDataModel> getRoomById(RoomGetByRoomIdParams params) async {
    try {
      final response = await servicelocator<DioHelper>().getData(
        url: '${EndPoints.getAllRooms}/${params.roomId}',
        headers: {
          "Authorization": "Bearer ${params.accessToken}",
        },
      );
      return AllRoomsDataModel.fromJson(response?.data['data']);
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }
}
