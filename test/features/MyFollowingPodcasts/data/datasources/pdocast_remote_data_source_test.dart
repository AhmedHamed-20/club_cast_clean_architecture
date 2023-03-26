import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/network_service.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/datasources/pdocast_remote_data_source.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/remove_like_by_podcast_id.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'podcast_remote_data_source_dumy_data.dart';

class MockNetworkService extends Mock implements NetworService {}

void main() {
  late MockNetworkService mockNetworkService;
  late MyFollowingPodcastRemoteDataSourceImpl podcastRemoteDataSourceImpl;
  setUp(() {
    mockNetworkService = MockNetworkService();
    podcastRemoteDataSourceImpl = MyFollowingPodcastRemoteDataSourceImpl(
      mockNetworkService,
    );
  });
  group('test my following podcast remote data source', () {
    test(
        'getMyFollowingPodcasts should return MyFollowingPodcastModel on right when success',
        () async {
      // arrange
      when(() => mockNetworkService.getData(
                url: any(named: 'url'),
                headers: any(named: 'headers'),
              ))
          .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: tMyFollowingPodcastModel.toJson()));

      // act
      final result = await podcastRemoteDataSourceImpl.getMyFollowingPodcasts(
          const MyFollowingPodcastParams('accessToken', 1));
      // assert
      expect(result, tMyFollowingPodcastModel);
      verify(() => mockNetworkService.getData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
          )).called(1);
    });
    test('getMyFollowingPodcasts should throw server exception on error',
        () async {
      // arrange
      when(() => mockNetworkService.getData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
          )).thenThrow(Exception('test'));
      // act
      result() => podcastRemoteDataSourceImpl
          .getMyFollowingPodcasts(const MyFollowingPodcastParams('test', 1));
      // assert
      await expectLater(result(), throwsA(isInstanceOf<ServerException>()));
      verify(() => mockNetworkService.getData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
          )).called(1);
    });
    test('addLikeToPodcasts should throw server exception on error', () async {
      // arrange
      when(() => mockNetworkService.postData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
            data: any(named: 'data'),
          )).thenThrow(Exception('test'));
      // act
      result() => podcastRemoteDataSourceImpl
          .addLikeToPodcasts(const LikeAddParams('test', 'test'));
      // assert
      await expectLater(result(), throwsA(isInstanceOf<ServerException>()));
      verify(() => mockNetworkService.postData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
            data: any(named: 'data'),
          )).called(1);
    });
    test('removeLikeFromPodcasts should throw server exception on error',
        () async {
      // arrange
      when(() => mockNetworkService.deleteData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
          )).thenThrow(Exception('test'));
      // act
      result() => podcastRemoteDataSourceImpl.removeLikeFromPodcasts(
          const LikeRemoveByPodcastIdParams(
              accessToken: 'test', podcastId: 'test'));
      // assert
      await expectLater(result(), throwsA(isInstanceOf<ServerException>()));
      verify(() => mockNetworkService.deleteData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
          )).called(1);
    });
  });
}
