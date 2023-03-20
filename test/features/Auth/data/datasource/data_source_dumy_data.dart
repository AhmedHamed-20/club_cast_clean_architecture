import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/models/auth_model.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/entities/auth_entity.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/login.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/sign_up.dart';
import 'package:dio/dio.dart';

final tSignUpMap = {
  "status": "success",
  "token": "accessToken",
  "data": {
    "user": {
      "photo": "/img/users/default.jpg",
      "role": "user",
      "followers": 0,
      "following": 0,
      "bio": "Hello There!",
      "uid": 19873,
      "_id": "641795e183ce9c0049390222",
      "name": "Hello hamed!",
      "email": "ahmed225588@gmail.com",
      "country": "egypt",
      "language": "arabic",
      "createdAt": "2023-03-19T23:08:17.997Z",
      "updatedAt": "2023-03-19T23:08:17.997Z"
    }
  }
};
const tAuthModel = AuthModel('accessToken');
const tAuthEntity = AuthEntity('accessToken');
final tLoginResponse = Response(
    data: tSignUpMap, requestOptions: RequestOptions(path: EndPoints.login));
final tSignUpResponse = Response(
    data: tSignUpMap, requestOptions: RequestOptions(path: EndPoints.signup));
final tDioError = DioError(
  response: tErrorResponse,
  requestOptions: RequestOptions(
    path: EndPoints.signup,
  ),
);
const SignUpParams tSignUpParams = SignUpParams(
  name: 'ahmed',
  email: 'test',
  password: 'test',
  confirmPassword: 'test',
);
const LoginParams tLoginParams = LoginParams('test', 'test');
final tErrorResponse = Response(
    requestOptions: RequestOptions(path: EndPoints.signup),
    data: {"status code": 404, "message": "error message"});
