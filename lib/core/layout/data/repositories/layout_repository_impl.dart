import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/layout/data/datasources/layout_remote_data_source_impl.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/category_entitie.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/my_following_events_entitie.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/user_data_entitie.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/repositories/base_layout_repository.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_cached_access_token.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_my_following_events.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_active_user_data.dart';

import '../datasources/layout_local_data_source_impl.dart';

class LayoutRepositoryImpl extends BaseLayoutRepository {
  final BaseLayoutRemoteDataSource baseLayoutRemoteDataSource;
  final BaseLayoutLocalDataSource baseLayoutLocalDataSource;
  LayoutRepositoryImpl(
      this.baseLayoutRemoteDataSource, this.baseLayoutLocalDataSource);
  @override
  Future<Either<Failure, UserDataEntitie>> getActiveUserData(
      ActiveUserDataGetParams params) async {
    try {
      final result = await baseLayoutRemoteDataSource.getActiveUserData(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(
          ServerFailure(message: exception.serverErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, String>> getAccessTokenFromCache(
      CachedAccessTokenGetParams params) async {
    try {
      final result =
          await baseLayoutLocalDataSource.accessTokenGetFromCache(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(
          ServerFailure(message: exception.serverErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, List<MyFollowingEventsEntitie>>> getMyFollowingEvents(
      MyFollowingEventsParams params) async {
    try {
      final result =
          await baseLayoutRemoteDataSource.getMyFollowingEvents(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(
          ServerFailure(message: exception.serverErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, CategoryEntitie>> getCategories(
      NoParams params) async {
    try {
      final result = await baseLayoutRemoteDataSource.getCategories(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(
          ServerFailure(message: exception.serverErrorMessageModel.message));
    }
  }
}
