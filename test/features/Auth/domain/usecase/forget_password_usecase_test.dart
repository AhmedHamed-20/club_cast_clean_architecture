import 'package:club_cast_clean_architecture/features/Auth/domain/repositories/auth_repository.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/forget_password.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'use_case_dumy_data.dart';

class MockBaseAuthRepository extends Mock implements BaseAuthRepository {}

void main() {
  late MockBaseAuthRepository mockBaseAuthRepository;
  late ForgetPasswordUsecase forgetPasswordUsecase;
  setUp(() {
    mockBaseAuthRepository = MockBaseAuthRepository();
    forgetPasswordUsecase = ForgetPasswordUsecase(mockBaseAuthRepository);
  });
  group('test forget password usecase ', () {
    test('forget password should return failure on error', () async {
      when(() => mockBaseAuthRepository
              .forgetPassword(const ForgetPasswordParams('email')))
          .thenAnswer((_) async => const Left(tServerFailure));

      final result =
          await forgetPasswordUsecase(const ForgetPasswordParams('email'));
      expect(result, const Left(tServerFailure));
      verify(() => mockBaseAuthRepository
          .forgetPassword(const ForgetPasswordParams('email'))).called(1);
    });
  });
}
