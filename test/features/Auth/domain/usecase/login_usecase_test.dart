import 'package:club_cast_clean_architecture/features/Auth/domain/repositories/auth_repository.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/login.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data/datasource/auth_data_source_dumy_data.dart';
import 'use_case_dumy_data.dart';

class MockBaseAuthRepository extends Mock implements BaseAuthRepository {}

void main() {
  late MockBaseAuthRepository mockBaseAuthRepository;
  late LoginUsecase loginUsecase;
  const LoginParams tLoginParams = LoginParams('email', 'password');
  setUp(() {
    mockBaseAuthRepository = MockBaseAuthRepository();
    loginUsecase = LoginUsecase(mockBaseAuthRepository);
  });
  group('test login usecae', () {
    test('login use case should return auth entity on success', () async {
      when(() => mockBaseAuthRepository.login(tLoginParams))
          .thenAnswer((_) async => const Right(tAuthEntity));
      final result = await loginUsecase(tLoginParams);
      expect(result, const Right(tAuthEntity));
      verify(() => mockBaseAuthRepository.login(tLoginParams)).called(1);
    });

    test('login use case should return failure on error', () async {
      when(() => mockBaseAuthRepository.login(tLoginParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      final result = await loginUsecase(tLoginParams);
      expect(result, const Left(tServerFailure));
      verify(() => mockBaseAuthRepository.login(tLoginParams)).called(1);
    });
  });
}
