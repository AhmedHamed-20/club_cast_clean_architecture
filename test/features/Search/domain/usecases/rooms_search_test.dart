import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/search_rooms_entity.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/repositories/base_search_repository.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/podcast_search.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/rooms_search.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data/datasources/remote_search_data_source_dumy_data.dart';

class MockBaseSearchRepository extends Mock implements BaseSearchRepository {}

void main() {
  late MockBaseSearchRepository mockBaseSearchRepository;
  late RoomsSearchUsecase roomsSearchUsecase;
  const SearchParams tSearchParams =
      SearchParams(accessToken: 'accessToken', query: 'query');
  const List<SearchRoomsEntity> tSearchRoomsModelList = [tSearchRoomsModel];
  const ServerFailure tServerFailure = ServerFailure(message: 'Server Failure');
  setUp(() {
    mockBaseSearchRepository = MockBaseSearchRepository();
    roomsSearchUsecase = RoomsSearchUsecase(mockBaseSearchRepository);
  });

  group('test rooms search usecase', () {
    test(
        'rooms search usecase should return list of rooms search entity on success',
        () async {
      // arrange
      when(() => mockBaseSearchRepository.roomsSearch(tSearchParams))
          .thenAnswer((_) async => const Right(tSearchRoomsModelList));
      // act
      final result = await roomsSearchUsecase(tSearchParams);
      // assert
      expect(result, const Right(tSearchRoomsModelList));
      verify(() => mockBaseSearchRepository.roomsSearch(tSearchParams))
          .called(1);
    });
    test('rooms search usecase should return Failure on error', () async {
      // arrange
      when(() => mockBaseSearchRepository.roomsSearch(tSearchParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      // act
      final result = await roomsSearchUsecase(tSearchParams);
      // assert
      expect(result, const Left(tServerFailure));
      verify(() => mockBaseSearchRepository.roomsSearch(tSearchParams))
          .called(1);
    });
  });
}
