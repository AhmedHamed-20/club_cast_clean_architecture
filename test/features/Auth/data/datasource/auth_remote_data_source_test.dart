import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/core/network/network_service.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/forget_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_data_source_dumy_data.dart';

class MockNetworkService extends Mock implements NetworkService {}

void main() {
  late MockNetworkService mockNetworkService;
  late AuthRemoteDataSourceImpl dataSource;
  setUp(() {
    mockNetworkService = MockNetworkService();
    dataSource = AuthRemoteDataSourceImpl(mockNetworkService);
  });
  group('test auth remote data source', () {
    test('should return auth model on signup success', () async {
      when(() => mockNetworkService.postData(
            url: EndPoints.signup,
            data: any(named: 'data'),
          )).thenAnswer((_) async => tSignUpResponse);

      final result = await dataSource.signUp(tSignUpParams);
      expect(result, tAuthModel);
      verify(() => mockNetworkService.postData(
            url: EndPoints.signup,
            data: any(named: 'data'),
          )).called(1);
    });

    test('sign up should throw server exception on dio error ', () async {
      when(() => mockNetworkService.postData(
            url: EndPoints.signup,
            data: any(named: 'data'),
          )).thenThrow(Exception('test'));
      resulut() => dataSource.signUp(tSignUpParams);
      await expectLater(resulut(), throwsA(isInstanceOf<ServerException>()));
      verify(() => mockNetworkService.postData(
            url: EndPoints.signup,
            data: any(named: 'data'),
          )).called(1);
    });

    test('sign in should return auth model on success', () async {
      when(() => mockNetworkService.postData(
            url: EndPoints.login,
            data: any(named: 'data'),
          )).thenAnswer((_) async => tLoginResponse);
      final result = await dataSource.login(tLoginParams);
      expect(result, tAuthModel);
      verify(() => mockNetworkService.postData(
            url: EndPoints.login,
            data: any(named: 'data'),
          )).called(1);
    });

    test('sign in should return server exception on failure ', () {
      when(() => mockNetworkService.postData(
            url: EndPoints.login,
            data: any(named: 'data'),
          )).thenThrow(Exception('test'));
      resulut() => dataSource.login(tLoginParams);
      expectLater(resulut(), throwsA(isInstanceOf<ServerException>()));
      verify(() => mockNetworkService.postData(
            url: EndPoints.login,
            data: any(named: 'data'),
          )).called(1);
    });

    test('forget password should return server exception on failure', () {
      when(() => mockNetworkService.postData(
            url: EndPoints.forgotPassword,
            data: any(named: 'data'),
          )).thenThrow(Exception('test'));
      resulut() =>
          dataSource.forgetPassword(const ForgetPasswordParams('test'));
      expectLater(resulut(), throwsA(isInstanceOf<ServerException>()));
      verify(() => mockNetworkService.postData(
            url: EndPoints.forgotPassword,
            data: any(named: 'data'),
          )).called(1);
    });
  });
}
