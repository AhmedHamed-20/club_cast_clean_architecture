import 'package:club_cast_clean_architecture/core/cache/cache_setup.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../repository/auth_repository_dumy_data.dart';

class MockCacheHelper extends Mock implements CacheService {}

void main() {
  late MockCacheHelper mockCacheHelper;
  late AuthLocalDataSourceImpl authLocalDataSourceImpl;

  setUp(() {
    mockCacheHelper = MockCacheHelper();
    authLocalDataSourceImpl = AuthLocalDataSourceImpl(mockCacheHelper);
  });

  group('test auth local data source', () {
    test('cache access token should return true on success', () async {
      when(() => mockCacheHelper.setData(
          key: any(named: 'key'),
          value: any(named: 'value'))).thenAnswer((_) async => true);
      final result = await authLocalDataSourceImpl
          .cacheAccessToken(tAccessTokenCacheParams);

      expect(result, true);
      verify(() => mockCacheHelper.setData(
          key: 'accessToken',
          value: tAccessTokenCacheParams.accessToken)).called(1);
    });

    test('cache access token should throw cache exception on error', () async {
      when(() => mockCacheHelper.setData(
          key: any(named: 'key'),
          value: any(named: 'value'))).thenThrow(Exception());
      result() =>
          authLocalDataSourceImpl.cacheAccessToken(tAccessTokenCacheParams);
      await expectLater(result(), throwsA(isA<CacheException>()));
      verify(() => mockCacheHelper.setData(
          key: 'accessToken',
          value: tAccessTokenCacheParams.accessToken)).called(1);
    });
  });
}
