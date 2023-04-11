import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/repositories/base_search_repository.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/all_podcasts.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data/datasources/remote_search_data_source_dumy_data.dart';

class MockBaseSearchRepository extends Mock implements BaseSearchRepository {}

void main() {
  late MockBaseSearchRepository mockBaseSearchRepository;
  late AllPodcastsUsecase allPodcastsUsecase;
  const AllPodcastsParams tAllPodcastParams =
      AllPodcastsParams(accessToken: 'accessToken', page: 1);
  const ServerFailure tServerFailure = ServerFailure(message: 'Server Failure');
  setUp(() {
    mockBaseSearchRepository = MockBaseSearchRepository();
    allPodcastsUsecase = AllPodcastsUsecase(mockBaseSearchRepository);
  });

  group('test all podcast get usecase', () {
    test('all podcast get usecase should return PodcastSearchEntity on success',
        () async {
      // arrange
      when(() => mockBaseSearchRepository.getAllPodcasts(tAllPodcastParams))
          .thenAnswer((_) async => const Right(tPodcastSearchModel));
      // act
      final result = await allPodcastsUsecase(tAllPodcastParams);
      // assert
      expect(result, const Right(tPodcastSearchModel));
      verify(() => mockBaseSearchRepository.getAllPodcasts(tAllPodcastParams))
          .called(1);
    });
    test('all podcast get usecase should return Failure on error', () async {
      // arrange
      when(() => mockBaseSearchRepository.getAllPodcasts(tAllPodcastParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      // act
      final result = await allPodcastsUsecase(tAllPodcastParams);
      // assert
      expect(result, const Left(tServerFailure));
      verify(() => mockBaseSearchRepository.getAllPodcasts(tAllPodcastParams))
          .called(1);
    });
  });
}
