import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/repositories/base_search_repository.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/podcast_search.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data/datasources/remote_search_data_source_dumy_data.dart';

class MockBaseSearchRepository extends Mock implements BaseSearchRepository {}

void main() {
  late MockBaseSearchRepository mockBaseSearchRepository;
  late PodcastSearchUsecase podcastSearchUsecase;
  const SearchParams tSearchParams =
      SearchParams(accessToken: 'accessToken', query: 'query');
  const ServerFailure tServerFailure = ServerFailure(message: 'Server Failure');
  setUp(() {
    mockBaseSearchRepository = MockBaseSearchRepository();
    podcastSearchUsecase = PodcastSearchUsecase(mockBaseSearchRepository);
  });

  group('test podcast search usecase', () {
    test('podcast search usecase should return PodcastSearchEntity on success',
        () async {
      // arrange
      when(() => mockBaseSearchRepository.podcastSearch(tSearchParams))
          .thenAnswer((_) async => const Right(tPodcastSearchModel));
      // act
      final result = await podcastSearchUsecase(tSearchParams);
      // assert
      expect(result, const Right(tPodcastSearchModel));
      verify(() => mockBaseSearchRepository.podcastSearch(tSearchParams))
          .called(1);
    });
    test('podcast search usecase should return Failure on error', () async {
      // arrange
      when(() => mockBaseSearchRepository.podcastSearch(tSearchParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      // act
      final result = await podcastSearchUsecase(tSearchParams);
      // assert
      expect(result, const Left(tServerFailure));
      verify(() => mockBaseSearchRepository.podcastSearch(tSearchParams))
          .called(1);
    });
  });
}
