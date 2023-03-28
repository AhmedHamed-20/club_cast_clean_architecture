import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/repositories/podcast_repository.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data/datasources/podcast_remote_data_source_dumy_data.dart';

class MockBaseMyFollowingPodcastRepository extends Mock
    implements BaseMyFollowingPodcastRepository {}

void main() {
  late MockBaseMyFollowingPodcastRepository
      mockBaseMyFollowingPodcastRepository;
  late MyFollowingPodcastGetUsecase myFollowingPodcastGetUsecase;
  setUp(() {
    mockBaseMyFollowingPodcastRepository =
        MockBaseMyFollowingPodcastRepository();
    myFollowingPodcastGetUsecase =
        MyFollowingPodcastGetUsecase(mockBaseMyFollowingPodcastRepository);
  });
  group('test my following podcast add like to podcast usecase', () {
    test(
        'get my following podcast should return MyFollowingPodcastEntity on right when success',
        () async {
      // arrange
      when(() => mockBaseMyFollowingPodcastRepository
              .getMyFollowingPodcast(const MyFollowingPodcastParams('test', 1)))
          .thenAnswer((_) async => const Right(tMyFollowingPodcastEntity));
      // act
      final result = (await myFollowingPodcastGetUsecase(
              const MyFollowingPodcastParams('test', 1)))
          .fold((l) => null, (r) => r);
      // assert
      expect(result, tMyFollowingPodcastEntity);
      verify(() => mockBaseMyFollowingPodcastRepository.getMyFollowingPodcast(
          const MyFollowingPodcastParams('test', 1))).called(1);
    });

    test('get my following podcast should return failure on left when error',
        () async {
      // arrange
      when(() => mockBaseMyFollowingPodcastRepository
              .getMyFollowingPodcast(const MyFollowingPodcastParams('test', 1)))
          .thenAnswer((_) async => const Left(ServerFailure(message: 'test')));
      // act
      final result = (await myFollowingPodcastGetUsecase(
              const MyFollowingPodcastParams('test', 1)))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<Failure>());
      verify(() => mockBaseMyFollowingPodcastRepository.getMyFollowingPodcast(
          const MyFollowingPodcastParams('test', 1))).called(1);
    });
  });
}
