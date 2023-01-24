import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/layout/data/models/my_following_events_model.dart';
import 'package:club_cast_clean_architecture/core/layout/data/models/user_data_model.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/my_following_events_entitie.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_active_user_data.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_my_following_events.dart';
import 'package:club_cast_clean_architecture/core/network/dio.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:dio/dio.dart';

import '../../../usecase/usecase.dart';
import '../models/category_model.dart';

abstract class BaseLayoutRemoteDataSource {
  Future<UserDataModel> getActiveUserData(ActiveUserDataGetParams params);
  Future<MyFollowingEventsEntitie> getMyFollowingEvents(
      MyFollowingEventsParams params);

  Future<CategoryModel> getCategories(NoParams params);
}

class LayoutRemoteDataSourceImpl extends BaseLayoutRemoteDataSource {
  @override
  Future<UserDataModel> getActiveUserData(
      ActiveUserDataGetParams params) async {
    try {
      final respone = await DioHelper.getData(
          url: EndPoints.getMe,
          headers: {'Authorization': 'Bearer ${params.accessToken}'});
      return UserDataModel.fromJson(respone?.data['data']['data']);
    } on DioError catch (e) {
      throw ServerException(
        serverErrorMessageModel: ServerErrorMessageModel.fromDioException(
          e,
        ),
      );
    }
  }

  @override
  Future<MyFollowingEventsEntitie> getMyFollowingEvents(
      MyFollowingEventsParams params) async {
    try {
      final respone = await DioHelper.getData(
          url: EndPoints.getMyFollowingEvent,
          headers: {'Authorization': 'Bearer ${params.accessToken}'});
      return MyFollowingEventsModel.fromJson(respone?.data);
    } on DioError catch (e) {
      throw ServerException(
        serverErrorMessageModel: ServerErrorMessageModel.fromDioException(
          e,
        ),
      );
    }
  }

  @override
  Future<CategoryModel> getCategories(NoParams params) async {
    try {
      final respone = await DioHelper.getData(
        url: EndPoints.allCategory,
      );
      return CategoryModel.fromJson(respone?.data);
    } on DioError catch (e) {
      throw ServerException(
        serverErrorMessageModel: ServerErrorMessageModel.fromDioException(
          e,
        ),
      );
    }
  }
}
