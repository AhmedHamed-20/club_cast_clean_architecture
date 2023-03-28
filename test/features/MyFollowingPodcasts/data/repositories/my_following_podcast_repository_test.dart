import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/datasources/pdocast_remote_data_source.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/repositories/my_following_podcast_repository.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entity.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/remove_like_by_podcast_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../datasources/podcast_remote_data_source_dumy_data.dart';

class MockMyFollowingPodcastRemoteDataSource extends Mock
    implements BaseMyFollowingPodcastRemoteDataSource {}

void main() {
  late MockMyFollowingPodcastRemoteDataSource
      mockMyFollowingPodcastRemoteDataSource;
  late MyFollowingPodcastRepositoryImple myFollowingPodcastRepositoryImple;
  const ServerException tServerException = ServerException(
      serverErrorMessageModel:
          ServerErrorMessageModel(message: 'test', statusCode: 400));
  setUp(() {
    mockMyFollowingPodcastRemoteDataSource =
        MockMyFollowingPodcastRemoteDataSource();
    myFollowingPodcastRepositoryImple = MyFollowingPodcastRepositoryImple(
        mockMyFollowingPodcastRemoteDataSource);
  });
  group('test my following podcast repository', () {
    test(
        'getMyFollowingPodcast should return MyFollowingPodcastEntity on right when success',
        () async {
      // arrange
      when(() => mockMyFollowingPodcastRemoteDataSource.getMyFollowingPodcasts(
              const MyFollowingPodcastParams('test', 1)))
          .thenAnswer((_) async => tMyFollowingPodcastModel);
      // act
      final result = (await myFollowingPodcastRepositoryImple
              .getMyFollowingPodcast(const MyFollowingPodcastParams('test', 1)))
          .fold((l) => null, (r) => r);
      // assert
      expect(result, isA<MyFollowingPodcastEntity>());
      verify(() =>
          mockMyFollowingPodcastRemoteDataSource.getMyFollowingPodcasts(
              const MyFollowingPodcastParams('test', 1))).called(1);
    });
    test(
        'getMyFollowingPodcast should return server failure when throw server exception',
        () async {
      // arrange
      when(() => mockMyFollowingPodcastRemoteDataSource.getMyFollowingPodcasts(
              const MyFollowingPodcastParams('test', 1)))
          .thenThrow(tServerException);
      // act
      final result = (await myFollowingPodcastRepositoryImple
              .getMyFollowingPodcast(const MyFollowingPodcastParams('test', 1)))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<ServerFailure>());
      verify(() =>
          mockMyFollowingPodcastRemoteDataSource.getMyFollowingPodcasts(
              const MyFollowingPodcastParams('test', 1))).called(1);
    });

    test(
        'addLikeToPodcast should return server failure when throw server exception',
        () async {
      // arrange
      when(() => mockMyFollowingPodcastRemoteDataSource.addLikeToPodcasts(
          const LikeAddParams('test', 'test'))).thenThrow(tServerException);
      //act
      final result = (await myFollowingPodcastRepositoryImple
              .addLikeToPodcast(const LikeAddParams('test', 'test')))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<ServerFailure>());
      verify(() => mockMyFollowingPodcastRemoteDataSource
          .addLikeToPodcasts(const LikeAddParams('test', 'test'))).called(1);
    });
    test(
        'removeLikeFromPodcasts should return server failure when throw server exception',
        () async {
      // arrange
      when(() => mockMyFollowingPodcastRemoteDataSource.removeLikeFromPodcasts(
          const LikeRemoveByPodcastIdParams(
              accessToken: 'test',
              podcastId: 'test'))).thenThrow(tServerException);
      //act
      final result = (await myFollowingPodcastRepositoryImple
              .removeLikeFromPodcast(const LikeRemoveByPodcastIdParams(
                  accessToken: 'test', podcastId: 'test')))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<ServerFailure>());
      verify(() => mockMyFollowingPodcastRemoteDataSource
          .removeLikeFromPodcasts(const LikeRemoveByPodcastIdParams(
              accessToken: 'test', podcastId: 'test'))).called(1);
    });
  });
}
