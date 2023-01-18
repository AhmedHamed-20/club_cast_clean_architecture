import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/dio.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:dio/dio.dart';

import '../../domain/usecases/get_user_profile_data.dart';
import '../models/other_users_data_model.dart';

abstract class BaseRemoteOtherUsersDataSorce {
  Future<OtherUserDataModel> getOtherUsersProfiles(
      UserProfileDataGetParams params);
}

class RemoteOtherUserDataSourceImpl extends BaseRemoteOtherUsersDataSorce {
  @override
  Future<OtherUserDataModel> getOtherUsersProfiles(
      UserProfileDataGetParams params) async {
    try {
      final response = await DioHelper.getData(
          url: EndPoints.userById + params.userId,
          headers: {
            'Authorization': 'Bearer ${params.accessToken}',
          });

      return OtherUserDataModel.fromJson(response?.data['data']);
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }
}
