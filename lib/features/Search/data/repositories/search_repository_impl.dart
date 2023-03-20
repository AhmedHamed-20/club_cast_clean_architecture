import 'package:club_cast_clean_architecture/features/Search/domain/entities/search_users_info_entity.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/search_rooms_entity.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/podcast_search_entity.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/repositories/base_search_repository.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/all_podcasts.dart';
import 'package:dartz/dartz.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/podcast_search.dart';

import '../../../../core/error/exception.dart';
import '../datasources/remote_search_data_source.dart';

class SearchRepositoryImpl extends BaseSearchRepository {
  final BaseRemoteSearchDataSoruce baseRemoteSearchDataSoruce;

  SearchRepositoryImpl(this.baseRemoteSearchDataSoruce);

  @override
  Future<Either<Failure, PodcastSearchEntity>> podcastSearch(
      SearchParams params) async {
    try {
      final result = await baseRemoteSearchDataSoruce.podcastSearch(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          message: e.serverErrorMessageModel.message,
          statusCode: e.serverErrorMessageModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<SearchRoomsEntity>>> roomsSearch(
      SearchParams params) async {
    try {
      final result = await baseRemoteSearchDataSoruce.roomsSearch(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          message: e.serverErrorMessageModel.message,
          statusCode: e.serverErrorMessageModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<SearchUsersEntity>>> usersSearch(
      SearchParams params) async {
    try {
      final result = await baseRemoteSearchDataSoruce.userSearch(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          message: e.serverErrorMessageModel.message,
          statusCode: e.serverErrorMessageModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, PodcastSearchEntity>> getAllPodcasts(
      AllPodcastsParams params) async {
    try {
      final result = await baseRemoteSearchDataSoruce.getAllPodcasts(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.serverErrorMessageModel.message,
          statusCode: e.serverErrorMessageModel.statusCode,
        ),
      );
    }
  }
}
