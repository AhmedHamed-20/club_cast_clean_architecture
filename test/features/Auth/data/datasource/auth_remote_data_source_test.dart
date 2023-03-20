import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/dio.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/forget_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'data_source_dumy_data.dart';

class MockDioHelper extends Mock implements DioHelper {}

void main() {
  late MockDioHelper mockDioHelper;
  late AuthRemoteDataSourceImpl dataSource;
  setUp(() {
    mockDioHelper = MockDioHelper();
    dataSource = AuthRemoteDataSourceImpl(mockDioHelper);
  });
  group('test auth remote data source', () {
    test('should return auth model on signup success', () async {
      when(() => mockDioHelper.postData(
            url: EndPoints.signup,
            data: any(named: 'data'),
          )).thenAnswer((_) async => tSignUpResponse);

      final result = await dataSource.signUp(tSignUpParams);
      expect(result, tAuthModel);
      verify(() => mockDioHelper.postData(
            url: EndPoints.signup,
            data: any(named: 'data'),
          )).called(1);
    });

    test('sign up should throw server exception on dio error ', () async {
      when(() => mockDioHelper.postData(
            url: EndPoints.signup,
            data: any(named: 'data'),
          )).thenThrow(tDioError);
      resulut() => dataSource.signUp(tSignUpParams);
      await expectLater(resulut(), throwsA(isInstanceOf<ServerException>()));
      verify(() => mockDioHelper.postData(
            url: EndPoints.signup,
            data: any(named: 'data'),
          )).called(1);
    });

    test('sign in should return auth model on success', () async {
      when(() => mockDioHelper.postData(
            url: EndPoints.login,
            data: any(named: 'data'),
          )).thenAnswer((_) async => tLoginResponse);
      final result = await dataSource.login(tLoginParams);
      expect(result, tAuthModel);
      verify(() => mockDioHelper.postData(
            url: EndPoints.login,
            data: any(named: 'data'),
          )).called(1);
    });

    test('sign in should return server exception on failure ', () {
      when(() => mockDioHelper.postData(
            url: EndPoints.login,
            data: any(named: 'data'),
          )).thenThrow(tDioError);
      resulut() => dataSource.login(tLoginParams);
      expectLater(resulut(), throwsA(isInstanceOf<ServerException>()));
      verify(() => mockDioHelper.postData(
            url: EndPoints.login,
            data: any(named: 'data'),
          )).called(1);
    });

    test('forget password should return server exception on failure', () {
      when(() => mockDioHelper.postData(
            url: EndPoints.forgotPassword,
            data: any(named: 'data'),
          )).thenThrow(tDioError);
      resulut() =>
          dataSource.forgetPassword(const ForgetPasswordParams('test'));
      expectLater(resulut(), throwsA(isInstanceOf<ServerException>()));
      verify(() => mockDioHelper.postData(
            url: EndPoints.forgotPassword,
            data: any(named: 'data'),
          )).called(1);
    });
  });
}
