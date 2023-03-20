import 'package:club_cast_clean_architecture/features/Auth/domain/repositories/auth_repository.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/sign_up.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data/datasource/auth_data_source_dumy_data.dart';
import 'use_case_dumy_data.dart';

class MockBaseAuthRepository extends Mock implements BaseAuthRepository {}

void main() {
  late MockBaseAuthRepository mockBaseAuthRepository;
  late SignUpUsecase signUpUsecase;
  const SignUpParams tSignUpParams = SignUpParams(
      email: 'email',
      password: 'password',
      confirmPassword: 'password',
      name: 'name');
  setUp(() {
    mockBaseAuthRepository = MockBaseAuthRepository();
    signUpUsecase = SignUpUsecase(mockBaseAuthRepository);
  });
  group('test sign up usecase', () {
    test('sign up usecase should return auth entity on success', () async {
      when(() => mockBaseAuthRepository.signUp(tSignUpParams))
          .thenAnswer((_) async => const Right(tAuthEntity));
      final result = await signUpUsecase(tSignUpParams);
      expect(result, const Right(tAuthEntity));
      verify(() => mockBaseAuthRepository.signUp(tSignUpParams)).called(1);
    });
    test('sign up usecase should return failure on error', () async {
      when(() => mockBaseAuthRepository.signUp(tSignUpParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      final result = await signUpUsecase(tSignUpParams);
      expect(result, const Left(tServerFailure));
      verify(() => mockBaseAuthRepository.signUp(tSignUpParams)).called(1);
    });
  });
}
