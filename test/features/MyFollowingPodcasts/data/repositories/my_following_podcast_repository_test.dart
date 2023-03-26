import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/datasources/pdocast_remote_data_source.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/repositories/my_following_podcast_repository.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entity.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../datasources/podcast_remote_data_source_dumy_data.dart';

class MockMyFollowingPodcastRemoteDataSource extends Mock
    implements BaseMyFollowingPodcastRemoteDataSource {}

void main() {
  late MockMyFollowingPodcastRemoteDataSource
      mockMyFollowingPodcastRemoteDataSource;
  late MyFollowingPodcastRepositoryImple myFollowingPodcastRepositoryImple;
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
    });
  });
}
