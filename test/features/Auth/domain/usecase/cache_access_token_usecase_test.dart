import 'package:club_cast_clean_architecture/features/Auth/domain/repositories/auth_repository.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/cache_access_token.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'use_case_dumy_data.dart';

class MockBaseAuthRepository extends Mock implements BaseAuthRepository {}

void main() {
  late MockBaseAuthRepository mockBaseAuthRepository;
  late AccessTokenCacheUsecase cacheAccessTokenUsecase;
  setUp(() {
    mockBaseAuthRepository = MockBaseAuthRepository();
    cacheAccessTokenUsecase = AccessTokenCacheUsecase(mockBaseAuthRepository);
  });
  group('test cache access token usecae', () {
    test('cache access token usecase should return true on success', () async {
      when(() => mockBaseAuthRepository
              .cacheAccessToken(const AccessTokenCacheParams('token')))
          .thenAnswer((_) async => const Right(true));
      final result =
          await cacheAccessTokenUsecase(const AccessTokenCacheParams('token'));
      expect(result, const Right(true));
      verify(() => mockBaseAuthRepository
          .cacheAccessToken(const AccessTokenCacheParams('token'))).called(1);
    });

    test('cache access token should return failure on error', () async {
      when(() => mockBaseAuthRepository
              .cacheAccessToken(const AccessTokenCacheParams('token')))
          .thenAnswer((_) async => const Left(tCacheFailure));
      final result =
          await cacheAccessTokenUsecase(const AccessTokenCacheParams('token'));
      expect(result, const Left(tCacheFailure));
      verify(() => mockBaseAuthRepository
          .cacheAccessToken(const AccessTokenCacheParams('token'))).called(1);
    });
  });
}
