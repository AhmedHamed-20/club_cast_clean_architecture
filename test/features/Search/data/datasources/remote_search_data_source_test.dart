import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/network_service.dart';
import 'package:club_cast_clean_architecture/features/Search/data/datasources/remote_search_data_source.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/all_podcasts.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/podcast_search.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'remote_search_data_source_dumy_data.dart';

class MockNetworkService extends Mock implements NetworkService {}

void main() {
  late MockNetworkService mockNetworkService;
  late RemoteSearchDataSource remoteSearchDataSource;
  const SearchParams tSearchParams =
      SearchParams(query: 'query', accessToken: 'accessToken');
  setUp(() {
    mockNetworkService = MockNetworkService();
    remoteSearchDataSource = RemoteSearchDataSource(mockNetworkService);
  });
  group('test remote search data source', () {
    test('podcastSearch should return podcast search model on success',
        () async {
      //arrange
      when(() => mockNetworkService.getData(
              url: any(named: 'url'), headers: any(named: 'headers')))
          .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: tPodcastSearchModel.toJson(),
              statusCode: 200));

      //act
      final result = await remoteSearchDataSource.podcastSearch(tSearchParams);
      //assert
      expect(result, tPodcastSearchModel);
      verify(() => mockNetworkService.getData(
          url: any(named: 'url'), headers: any(named: 'headers'))).called(1);
    });
    test('podcastSearch should return server exception when throw exception',
        () async {
      //arrange
      when(() => mockNetworkService.getData(
          url: any(named: 'url'),
          headers: any(named: 'headers'))).thenThrow(Exception());

      //act
      result() => remoteSearchDataSource.podcastSearch(tSearchParams);
      //assert
      await expectLater(result(), throwsA(isA<ServerException>()));
      verify(() => mockNetworkService.getData(
          url: any(named: 'url'), headers: any(named: 'headers'))).called(1);
    });

    test('RoomsSearch should return rooms search model on success', () async {
      //arrange
      when(() => mockNetworkService.getData(
              url: any(named: 'url'), headers: any(named: 'headers')))
          .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: {
                'data': [tSearchRoomsModel.toJson()]
              },
              statusCode: 200));
      //act
      final result = await remoteSearchDataSource.roomsSearch(tSearchParams);
      //assert
      expect(result, [tSearchRoomsModel]);
      verify(() => mockNetworkService.getData(
          url: any(named: 'url'), headers: any(named: 'headers'))).called(1);
    });
    test('roomsSearch should return server exception when throw exception',
        () async {
      //arrange
      when(() => mockNetworkService.getData(
          url: any(named: 'url'),
          headers: any(named: 'headers'))).thenThrow(Exception());

      //act
      result() => remoteSearchDataSource.roomsSearch(tSearchParams);
      //assert
      await expectLater(result(), throwsA(isA<ServerException>()));
      verify(() => mockNetworkService.getData(
          url: any(named: 'url'), headers: any(named: 'headers'))).called(1);
    });
    test('userSearch should return user search model on success', () async {
      //arrange
      when(() => mockNetworkService.getData(
              url: any(named: 'url'), headers: any(named: 'headers')))
          .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: {
                'data': [tSearchUsersModel.toJson()]
              },
              statusCode: 200));
      //act
      final result = await remoteSearchDataSource.userSearch(tSearchParams);
      //assert
      expect(result, [tSearchUsersModel]);
      verify(() => mockNetworkService.getData(
          url: any(named: 'url'), headers: any(named: 'headers'))).called(1);
    });
    test('roomsSearch should return server exception when throw exception',
        () async {
      //arrange
      when(() => mockNetworkService.getData(
          url: any(named: 'url'),
          headers: any(named: 'headers'))).thenThrow(Exception());

      //act
      result() => remoteSearchDataSource.userSearch(tSearchParams);
      //assert
      await expectLater(result(), throwsA(isA<ServerException>()));
      verify(() => mockNetworkService.getData(
          url: any(named: 'url'), headers: any(named: 'headers'))).called(1);
    });
    test('allPodcasts should return podcast search model on success', () async {
      //arrange
      when(() => mockNetworkService.getData(
              url: any(named: 'url'),
              headers: any(named: 'headers'),
              query: any(named: 'query')))
          .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: tPodcastSearchModel.toJson(),
              statusCode: 200));
      //act
      final result = await remoteSearchDataSource.getAllPodcasts(
          const AllPodcastsParams(accessToken: 'accessToken', page: 1));
      //assert
      expect(result, tPodcastSearchModel);
      verify(() => mockNetworkService.getData(
          url: any(named: 'url'),
          headers: any(named: 'headers'),
          query: any(named: 'query'))).called(1);
    });
    test('allPodcasts should return server exception when throw exception',
        () async {
      //arrange
      when(() => mockNetworkService.getData(
          url: any(named: 'url'),
          headers: any(named: 'headers'),
          query: any(named: 'query'))).thenThrow(Exception());

      //act
      result() => remoteSearchDataSource.getAllPodcasts(
          const AllPodcastsParams(accessToken: 'accessToken', page: 1));
      //assert
      await expectLater(result(), throwsA(isA<ServerException>()));
      verify(() => mockNetworkService.getData(
          url: any(named: 'url'),
          headers: any(named: 'headers'),
          query: any(named: 'query'))).called(1);
    });
  });
}
