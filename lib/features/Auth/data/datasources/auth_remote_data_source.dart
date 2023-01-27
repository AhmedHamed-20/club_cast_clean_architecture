import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/dio.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/models/auth_model.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/forget_password.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/login.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/sign_up.dart';
import 'package:dio/dio.dart';

import '../../../../core/services/service_locator.dart';

abstract class BaseAuthRemoteDataSource {
  Future<AuthModel> signUp(SignUpParams params);
  Future<AuthModel> login(LoginParams params);
  Future<void> forgetPassword(ForgetPasswordParams params);
}

class AuthRemoteDataSourceImpl extends BaseAuthRemoteDataSource {
  @override
  Future<AuthModel> signUp(SignUpParams params) async {
    try {
      final respone = await servicelocator<DioHelper>()
          .postData(url: EndPoints.signup, data: {
        'name': params.name,
        'email': params.email,
        'password': params.password,
        'passwordConfirm': params.confirmPassword,
        "country": "egypt",
        "language": "arabic",
      });

      return AuthModel.fromJson(respone?.data);
    } on DioError catch (error) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromDioException(error));
    }
  }

  @override
  Future<AuthModel> login(LoginParams params) async {
    try {
      final response = await servicelocator<DioHelper>()
          .postData(url: EndPoints.login, data: {
        'email': params.email,
        'password': params.password,
      });
      return AuthModel.fromJson(response?.data);
    } on DioError catch (error) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromDioException(error));
    }
  }

  @override
  Future<void> forgetPassword(ForgetPasswordParams params) async {
    try {
      await servicelocator<DioHelper>()
          .postData(url: EndPoints.forgotPassword, data: {
        'email': params.email,
      });
    } on DioError catch (error) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromDioException(error));
    }
  }
}
