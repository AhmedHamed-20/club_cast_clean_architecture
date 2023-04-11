import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/search_users_info_entity.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/repositories/base_search_repository.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/podcast_search.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/users_search.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data/datasources/remote_search_data_source_dumy_data.dart';

class MockBaseSearchRepository extends Mock implements BaseSearchRepository {}

void main() {
  late MockBaseSearchRepository mockBaseSearchRepository;
  late UsersSearchUsecase usersSearchUsecase;
  const SearchParams tSearchParams =
      SearchParams(accessToken: 'accessToken', query: 'query');
  const List<SearchUsersEntity> tSearchUsersModelList = [tSearchUsersModel];
  const ServerFailure tServerFailure = ServerFailure(message: 'Server Failure');
  setUp(() {
    mockBaseSearchRepository = MockBaseSearchRepository();
    usersSearchUsecase = UsersSearchUsecase(mockBaseSearchRepository);
  });

  group('test users search usecase', () {
    test(
        'users search usecase should return list of users search entity on success',
        () async {
      // arrange
      when(() => mockBaseSearchRepository.usersSearch(tSearchParams))
          .thenAnswer((_) async => const Right(tSearchUsersModelList));
      // act
      final result = await usersSearchUsecase(tSearchParams);
      // assert
      expect(result, const Right(tSearchUsersModelList));
      verify(() => mockBaseSearchRepository.usersSearch(tSearchParams))
          .called(1);
    });
    test('rooms search usecase should return Failure on error', () async {
      // arrange
      when(() => mockBaseSearchRepository.usersSearch(tSearchParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      // act
      final result = await usersSearchUsecase(tSearchParams);
      // assert
      expect(result, const Left(tServerFailure));
      verify(() => mockBaseSearchRepository.usersSearch(tSearchParams))
          .called(1);
    });
  });
}
