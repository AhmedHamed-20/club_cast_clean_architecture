import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/datasources/pdocast_remote_data_source.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entity.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/repositories/podcast_repository.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_more_my_following_podcasts.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/remove_like_by_podcast_id.dart';
import 'package:dartz/dartz.dart';

class PodcastRepositoryImple extends BasePodcastRepository {
  final BasePodcastRemoteDataSource basePodcastRemoteDataSource;

  PodcastRepositoryImple(this.basePodcastRemoteDataSource);
  @override
  Future<Either<Failure, MyFollowingPodcastEntity>> getMyFollowingPodcast(
      MyFollowingPodcastParams params) async {
    try {
      final result =
          await basePodcastRemoteDataSource.getMyFollowingPodcasts(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
        message: exception.serverErrorMessageModel.message,
        statusCode: exception.serverErrorMessageModel.statusCode,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> addLikeToPodcast(LikeAddParams params) async {
    try {
      final result =
          await basePodcastRemoteDataSource.addLikeToPodcasts(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
        message: exception.serverErrorMessageModel.message,
        statusCode: exception.serverErrorMessageModel.statusCode,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> removeLikeFromPodcast(
      LikeRemoveByPodcastIdParams params) async {
    try {
      final result =
          await basePodcastRemoteDataSource.removeLikeFromPodcasts(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
        message: exception.serverErrorMessageModel.message,
        statusCode: exception.serverErrorMessageModel.statusCode,
      ));
    }
  }

  @override
  Future<Either<Failure, MyFollowingPodcastEntity>> getMoreMyFollowingPodcast(
      MoreMyFollowingPodcastParams params) async {
    try {
      final result =
          await basePodcastRemoteDataSource.getMoreMyFollowingPodcasts(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
          message: exception.serverErrorMessageModel.message,
          statusCode: exception.serverErrorMessageModel.statusCode));
    }
  }
}
