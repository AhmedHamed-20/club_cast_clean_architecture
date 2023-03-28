import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/repositories/podcast_repository.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/add_like.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBaseMyFollowingPodcastRepository extends Mock
    implements BaseMyFollowingPodcastRepository {}

void main() {
  late MockBaseMyFollowingPodcastRepository
      mockBaseMyFollowingPodcastRepository;
  late MyFollowingPodcastLikeAddByIdUsecase
      myFollowingPodcastLikeAddByIdUsecase;

  setUp(() {
    mockBaseMyFollowingPodcastRepository =
        MockBaseMyFollowingPodcastRepository();
    myFollowingPodcastLikeAddByIdUsecase = MyFollowingPodcastLikeAddByIdUsecase(
        mockBaseMyFollowingPodcastRepository);
  });
  group('test my following podcast add like to podcast usecase', () {
    test('add like to podcast should return failure on left when error',
        () async {
      // arrange
      when(() => mockBaseMyFollowingPodcastRepository
              .addLikeToPodcast(const LikeAddParams('test', 'test')))
          .thenAnswer((_) async => const Left(ServerFailure(message: 'test')));
      // act
      final result = (await myFollowingPodcastLikeAddByIdUsecase(
              const LikeAddParams('test', 'test')))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<Failure>());
      verify(() => mockBaseMyFollowingPodcastRepository
          .addLikeToPodcast(const LikeAddParams('test', 'test'))).called(1);
    });
  });
}
