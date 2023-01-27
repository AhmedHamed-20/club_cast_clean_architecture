import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/dio.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/models/all_rooms_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/usecases/get_all_rooms.dart';
import 'package:dio/dio.dart';

import '../../../../core/services/service_locator.dart';

abstract class BaseRemoteRoomsDataSource {
  Future<AllRoomsModel> getAllRooms(AllRoomsGetParams params);
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
}
