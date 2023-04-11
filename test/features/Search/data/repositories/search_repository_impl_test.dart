import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Search/data/datasources/remote_search_data_source.dart';
import 'package:club_cast_clean_architecture/features/Search/data/repositories/search_repository_impl.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/podcast_search_entity.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/search_rooms_entity.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/search_users_info_entity.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/all_podcasts.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/podcast_search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../datasources/remote_search_data_source_dumy_data.dart';

class MockSearchRemoteDataSource extends Mock
    implements RemoteSearchDataSource {}

void main() {
  late MockSearchRemoteDataSource mockSearchRemoteDataSource;
  late SearchRepositoryImpl searchRepositoryImpl;
  const SearchParams tSearchParams =
      SearchParams(accessToken: 'accessToken', query: 'query');
  const ServerException tServerException = ServerException(
      serverErrorMessageModel: ServerErrorMessageModel(message: 'message'));
  const AllPodcastsParams tAllPodcastParams =
      AllPodcastsParams(accessToken: 'accessToken', page: 1);
  setUp(() {
    mockSearchRemoteDataSource = MockSearchRemoteDataSource();
    searchRepositoryImpl = SearchRepositoryImpl(
      mockSearchRemoteDataSource,
    );
  });

  group('test search repository', () {
    test('podcastSearch should return podcast entity when success', () async {
      // arrange
      when(() => mockSearchRemoteDataSource.podcastSearch(tSearchParams))
          .thenAnswer((_) async => tPodcastSearchModel);
      // act
      final result = (await searchRepositoryImpl.podcastSearch(tSearchParams))
          .fold((l) => null, (r) => r);
      // assert
      expect(result, isA<PodcastSearchEntity>());
      verify(() => mockSearchRemoteDataSource.podcastSearch(tSearchParams))
          .called(1);
    });
    test('podcastSearch should return failure when error happen', () async {
      // arrange
      when(() => mockSearchRemoteDataSource.podcastSearch(tSearchParams))
          .thenThrow(tServerException);
      // act
      final result = (await searchRepositoryImpl.podcastSearch(tSearchParams))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<Failure>());
      verify(() => mockSearchRemoteDataSource.podcastSearch(tSearchParams))
          .called(1);
    });

    test('roomsSearch should return list of rooms search entity when success',
        () async {
      // arrange
      when(() => mockSearchRemoteDataSource.roomsSearch(tSearchParams))
          .thenAnswer((_) async => [tSearchRoomsModel]);
      // act
      final result = (await searchRepositoryImpl.roomsSearch(tSearchParams))
          .fold((l) => null, (r) => r);
      // assert
      expect(result, isA<List<SearchRoomsEntity>>());
      verify(() => mockSearchRemoteDataSource.roomsSearch(tSearchParams))
          .called(1);
    });
    test('roomsSearch should return failure when error happen', () async {
      // arrange
      when(() => mockSearchRemoteDataSource.roomsSearch(tSearchParams))
          .thenThrow(tServerException);
      // act
      final result = (await searchRepositoryImpl.roomsSearch(tSearchParams))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<Failure>());
      verify(() => mockSearchRemoteDataSource.roomsSearch(tSearchParams))
          .called(1);
    });

    test('usersSearch should return list of users search entity when success',
        () async {
      // arrange
      when(() => mockSearchRemoteDataSource.userSearch(tSearchParams))
          .thenAnswer((_) async => [tSearchUsersModel]);
      // act
      final result = (await searchRepositoryImpl.usersSearch(tSearchParams))
          .fold((l) => null, (r) => r);
      // assert
      expect(result, isA<List<SearchUsersEntity>>());
      verify(() => mockSearchRemoteDataSource.userSearch(tSearchParams))
          .called(1);
    });
    test('usersSearch should return failure when error happen', () async {
      // arrange
      when(() => mockSearchRemoteDataSource.userSearch(tSearchParams))
          .thenThrow(tServerException);
      // act
      final result = (await searchRepositoryImpl.usersSearch(tSearchParams))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<Failure>());
      verify(() => mockSearchRemoteDataSource.userSearch(tSearchParams))
          .called(1);
    });

    test('getAllPodcasts should return podcast entity when success', () async {
      // arrange
      when(() => mockSearchRemoteDataSource.getAllPodcasts(tAllPodcastParams))
          .thenAnswer((_) async => tPodcastSearchModel);
      // act
      final result =
          (await searchRepositoryImpl.getAllPodcasts(tAllPodcastParams))
              .fold((l) => null, (r) => r);
      // assert
      expect(result, isA<PodcastSearchEntity>());
      verify(() => mockSearchRemoteDataSource.getAllPodcasts(tAllPodcastParams))
          .called(1);
    });
    test('usersSearch should return failure when error happen', () async {
      // arrange
      when(() => mockSearchRemoteDataSource.getAllPodcasts(tAllPodcastParams))
          .thenThrow(tServerException);
      // act
      final result =
          (await searchRepositoryImpl.getAllPodcasts(tAllPodcastParams))
              .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<Failure>());
      verify(() => mockSearchRemoteDataSource.getAllPodcasts(tAllPodcastParams))
          .called(1);
    });
  });
}
