import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/datasources/auth_local_data_source.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/repositories/auth_repository.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/entities/auth_entity.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/forget_password.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../datasource/data_source_dumy_data.dart';

class MockRemoteAuthDataSource extends Mock
    implements AuthRemoteDataSourceImpl {}

class MockLocalAuthDataSource extends Mock implements AuthLocalDataSourceImpl {}

void main() {
  late MockRemoteAuthDataSource mockRemoteAuthDataSource;
  late MockLocalAuthDataSource mockLocalAuthDataSource;
  late AuthRepositoryImple authRepositoryImpl;

  setUp(() {
    mockRemoteAuthDataSource = MockRemoteAuthDataSource();
    mockLocalAuthDataSource = MockLocalAuthDataSource();
    authRepositoryImpl = AuthRepositoryImple(
      mockRemoteAuthDataSource,
      mockLocalAuthDataSource,
    );
  });
  group('test auth repository', () {
    test('sign up should retrun auth entitie on right on success', () async {
      when(() => mockRemoteAuthDataSource.signUp(tSignUpParams))
          .thenAnswer((_) async => tAuthModel);

      final result = (await authRepositoryImpl.signUp(tSignUpParams))
          .fold((l) => null, (r) => r);

      expect(result, tAuthModel);
      verify(() => mockRemoteAuthDataSource.signUp(tSignUpParams)).called(1);
    });
    test('sign up should return server failure on left', () async {
      when(() => mockRemoteAuthDataSource.signUp(tSignUpParams)).thenThrow(
          ServerException(
              serverErrorMessageModel:
                  ServerErrorMessageModel.fromDioException(tDioError)));

      final result = (await authRepositoryImpl.signUp(tSignUpParams))
          .fold((l) => l, (r) => null);

      expect(result, isA<ServerFailure>());
      verify(() => mockRemoteAuthDataSource.signUp(tSignUpParams)).called(1);
    });

    test('sign in should return auth entity on the right', () async {
      when(() => mockRemoteAuthDataSource.login(tLoginParams))
          .thenAnswer((_) async => tAuthModel);

      final result = (await authRepositoryImpl.login(tLoginParams))
          .fold((l) => null, (r) => r);

      expect(result, tAuthModel);
      verify(() => mockRemoteAuthDataSource.login(tLoginParams)).called(1);
    });

    test('sign in should return server failure on left on error', () async {
      when(() => mockRemoteAuthDataSource.login(tLoginParams)).thenThrow(
          ServerException(
              serverErrorMessageModel:
                  ServerErrorMessageModel.fromDioException(tDioError)));

      final result = (await authRepositoryImpl.login(tLoginParams))
          .fold((l) => l, (r) => null);

      expect(result, isA<ServerFailure>());
      verify(() => mockRemoteAuthDataSource.login(tLoginParams)).called(1);
    });

    test('forget password should return server failure on left on error',
        () async {
      when(() => mockRemoteAuthDataSource
              .forgetPassword(const ForgetPasswordParams('test')))
          .thenThrow(ServerException(
              serverErrorMessageModel:
                  ServerErrorMessageModel.fromDioException(tDioError)));

      final result = (await authRepositoryImpl
              .forgetPassword(const ForgetPasswordParams('test')))
          .fold((l) => l, (r) => null);

      expect(result, isA<ServerFailure>());
      verify(() => mockRemoteAuthDataSource
          .forgetPassword(const ForgetPasswordParams('test'))).called(1);
    });
  });
}
