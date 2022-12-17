import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/layout/data/models/user_data_model.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_active_user_data.dart';
import 'package:club_cast_clean_architecture/core/network/dio.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:dio/dio.dart';

abstract class BaseLayoutRemoteDataSource {
  Future<UserDataModel> getActiveUserData(ActiveUserDataGetParams params);
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
        serverErrorMessageModel: ServerErrorMessageModel.fromJson(
          e.response?.data,
        ),
      );
    }
  }
}
