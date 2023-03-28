import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/repositories/podcast_repository.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/remove_like_by_podcast_id.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBaseMyFollowingPodcastRepository extends Mock
    implements BaseMyFollowingPodcastRepository {}

void main() {
  late MockBaseMyFollowingPodcastRepository
      mockBaseMyFollowingPodcastRepository;
  late MyFollowingPodcastLikeRemoveByPodcastIdUsecase
      myFollowingPodcastLikeRemoveByPodcastIdUsecase;
  setUp(() {
    mockBaseMyFollowingPodcastRepository =
        MockBaseMyFollowingPodcastRepository();
    myFollowingPodcastLikeRemoveByPodcastIdUsecase =
        MyFollowingPodcastLikeRemoveByPodcastIdUsecase(
            mockBaseMyFollowingPodcastRepository);
  });
  group('test MyFollowingPodcastLikeRemoveByPodcastIdUsecase', () {
    test(
        'MyFollowingPodcastLikeRemoveByPodcastIdUsecase should return failure on left when error occurs',
        () async {
      // arrange
      when(() => mockBaseMyFollowingPodcastRepository.removeLikeFromPodcast(
              const LikeRemoveByPodcastIdParams(
                  accessToken: 'test', podcastId: 'test')))
          .thenAnswer((_) async => const Left(ServerFailure(message: 'test')));
      // act
      final result = (await myFollowingPodcastLikeRemoveByPodcastIdUsecase(
              const LikeRemoveByPodcastIdParams(
                  accessToken: 'test', podcastId: 'test')))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<Failure>());
      verify(() => mockBaseMyFollowingPodcastRepository.removeLikeFromPodcast(
          const LikeRemoveByPodcastIdParams(
              accessToken: 'test', podcastId: 'test'))).called(1);
    });
  });
}
