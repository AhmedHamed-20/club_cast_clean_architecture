import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/network_service.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/datasources/remote_other_users_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'remote_other_users_dumy_data.dart';

class MockNetworkService extends Mock implements NetworkService {}

void main() {
  late MockNetworkService mockNetworkService;
  late RemoteOtherUserDataSourceImpl remoteOtherUserDataSourceImpl;

  setUp(() {
    mockNetworkService = MockNetworkService();
    remoteOtherUserDataSourceImpl =
        RemoteOtherUserDataSourceImpl(mockNetworkService);
  });

  group('test other users remote data source', () {
    test('getOtherUsersProfiles should return OtherUserDataModel when success',
        () async {
      //arrange
      when(() => mockNetworkService.getData(
              url: any(named: 'url'), headers: any(named: 'headers')))
          .thenAnswer((invocation) async => Response(data: {
                'data': tOtherUsersDataModel.toJson(),
              }, requestOptions: RequestOptions(path: '')));
      //act
      final result = await remoteOtherUserDataSourceImpl
          .getOtherUsersProfiles(tOtherUserProfileDataSourceParams);
      expect(result, tOtherUsersDataModel);
      verify(() => mockNetworkService.getData(
          url: any(
            named: 'url',
          ),
          headers: any(named: 'headers'))).called(1);
    });
    test(
        'getOtherUsersProfiles should throw servers exception when error throw exception',
        () async {
      //arrange
      when(() => mockNetworkService.getData(
          url: any(named: 'url'),
          headers: any(named: 'headers'))).thenThrow(Exception('error'));
      //act
      result() => remoteOtherUserDataSourceImpl
          .getOtherUsersProfiles(tOtherUserProfileDataSourceParams);
      //assert
      await expectLater(result(), throwsA(isA<ServerException>()));
      verify(() => mockNetworkService.getData(
          url: any(
            named: 'url',
          ),
          headers: any(named: 'headers'))).called(1);
    });
    test(
        'getUserFollowers should return other user followers following model when success',
        () async {
      //arrange
      when(() => mockNetworkService.getData(
          url: any(named: 'url'),
          headers: any(named: 'headers'),
          query: any(named: 'query'))).thenAnswer(
        (_) async => Response(
          data: tOtherUserFollowersFollowingDataModel.toJson(true),
          requestOptions: RequestOptions(path: ''),
        ),
      );
      //act
      final result = await remoteOtherUserDataSourceImpl
          .getUserFollowers(tOtherUserFollowersFollowingParams);
      //assert
      expect(result, tOtherUserFollowersFollowingDataModel);
      verify(
        () => mockNetworkService.getData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
            query: any(named: 'query')),
      ).called(1);
    });
    test('getUserFollowers should throw server exception when error occurs',
        () async {
      //arrange
      when(() => mockNetworkService.getData(
          url: any(named: 'url'),
          headers: any(named: 'headers'),
          query: any(named: 'query'))).thenThrow(Exception('error'));
      //act
      result() => remoteOtherUserDataSourceImpl
          .getUserFollowers(tOtherUserFollowersFollowingParams);
      await expectLater(result(), throwsA(isA<ServerException>()));
      verify(
        () => mockNetworkService.getData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
            query: any(named: 'query')),
      ).called(1);
    });
    test(
        'getUserFollowing should return other user followers following model when success',
        () async {
      //arrange
      when(() => mockNetworkService.getData(
          url: any(named: 'url'),
          headers: any(named: 'headers'),
          query: any(named: 'query'))).thenAnswer(
        (_) async => Response(
          data: tOtherUserFollowersFollowingDataModel.toJson(false),
          requestOptions: RequestOptions(path: ''),
        ),
      );
      //act
      final result = await remoteOtherUserDataSourceImpl
          .getUserFollowing(tOtherUserFollowersFollowingParams);
      //assert
      expect(result, tOtherUserFollowersFollowingDataModel);
      verify(
        () => mockNetworkService.getData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
            query: any(named: 'query')),
      ).called(1);
    });
    test('getUserFollowing should throw server exception when error occurs',
        () async {
      //arrange
      when(() => mockNetworkService.getData(
          url: any(named: 'url'),
          headers: any(named: 'headers'),
          query: any(named: 'query'))).thenThrow(Exception('error'));
      //act
      result() => remoteOtherUserDataSourceImpl
          .getUserFollowing(tOtherUserFollowersFollowingParams);
      await expectLater(result(), throwsA(isA<ServerException>()));
      verify(
        () => mockNetworkService.getData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
            query: any(named: 'query')),
      ).called(1);
    });
    test(
        'getOtherUserPodcasts should return other users podcast model on success',
        () async {
      //arrange
      when(
        () => mockNetworkService.getData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
            query: any(named: 'query')),
      ).thenAnswer((invocation) async => Response(
          data: tOtherUserPodcastModel.toJson(),
          requestOptions: RequestOptions(path: '')));

      //act
      final result = await remoteOtherUserDataSourceImpl
          .getOtherUserPodcasts(tOtherUserPodcastParams);
      //assert
      expect(result, tOtherUserPodcastModel);
      verify(() => mockNetworkService.getData(
          url: any(named: 'url'),
          headers: any(named: 'headers'),
          query: any(named: 'query'))).called(1);
    });
    test('getOtherUserPodcasts should throw server exception when error occurs',
        () async {
      //arrange
      when(
        () => mockNetworkService.getData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
            query: any(named: 'query')),
      ).thenThrow(Exception('error'));

      //act
      result() => remoteOtherUserDataSourceImpl
          .getOtherUserPodcasts(tOtherUserPodcastParams);
      //assert
      await expectLater(result, throwsA(isA<ServerException>()));
      verify(() => mockNetworkService.getData(
          url: any(named: 'url'),
          headers: any(named: 'headers'),
          query: any(named: 'query'))).called(1);
    });
    test('follow user should throw server exception when error occurs',
        () async {
      //arrange
      when(
        () => mockNetworkService.postData(
          url: any(named: 'url'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(Exception('error'));

      //act
      result() =>
          remoteOtherUserDataSourceImpl.followUser(tFollowUnfollowUserParams);
      //assert
      await expectLater(result(), throwsA(isA<ServerException>()));
      verify(() => mockNetworkService.postData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
          )).called(1);
    });
    test('un follow user should throw server exception when error occurs',
        () async {
      //arrange
      when(
        () => mockNetworkService.deleteData(
          url: any(named: 'url'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(Exception('error'));

      //act
      result() =>
          remoteOtherUserDataSourceImpl.unFollowUser(tFollowUnfollowUserParams);
      //assert
      await expectLater(result(), throwsA(isA<ServerException>()));
      verify(() => mockNetworkService.deleteData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
          )).called(1);
    });
    test('getOtherUserEvents should return OtherUserEventsModel on success',
        () async {
      //arrange
      when(
        () => mockNetworkService.getData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
            query: any(named: 'query')),
      ).thenAnswer((invocation) async => Response(
          data: tOtherUserEventsModel.toJson(),
          requestOptions: RequestOptions(path: '')));

      //act
      final result = await remoteOtherUserDataSourceImpl
          .getOtherUserEvents(tOtherUserEventsParams);
      //assert
      expect(result, tOtherUserEventsModel);
      verify(() => mockNetworkService.getData(
          url: any(named: 'url'),
          headers: any(named: 'headers'),
          query: any(named: 'query'))).called(1);
    });
    test('getOtherUserEvents should throw server exception when error occurs',
        () async {
      //arrange
      when(
        () => mockNetworkService.getData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
            query: any(named: 'query')),
      ).thenThrow(Exception('error'));

      //act
      result() => remoteOtherUserDataSourceImpl
          .getOtherUserEvents(tOtherUserEventsParams);
      //assert
      await expectLater(result(), throwsA(isA<ServerException>()));
      verify(
        () => mockNetworkService.getData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
            query: any(named: 'query')),
      ).called(1);
    });
  });
}
