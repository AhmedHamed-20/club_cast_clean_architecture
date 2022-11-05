import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Podcast/data/datasources/pdocast_remote_data_source.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/entities/podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/entities/podcast_likes_users_entitie.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/repositories/podcast_repository.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/get_podcast_likes_users.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/remove_like_by_podcast_id.dart';
import 'package:dartz/dartz.dart';

class PodcastRepositoryImple extends BasePodcastRepository {
  final BasePodcastRemoteDataSource basePodcastRemoteDataSource;

  PodcastRepositoryImple(this.basePodcastRemoteDataSource);
  @override
  Future<Either<Failure, List<PodcastEntitie>>> getMyFollowingPodcast(
      MyFollowingPodcastParams params) async {
    try {
      final result =
          await basePodcastRemoteDataSource.getMyFollowingPodcasts(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
        message: exception.serverErrorMessageModel.message,
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
      ));
    }
  }

  @override
  Future<Either<Failure, List<PodcastLikesUsersInfoEntitie>>>
      getPodcastLikesUsers(PodcastLikesUsersparams params) async {
    try {
      final result =
          await basePodcastRemoteDataSource.getPodcastLikesUsers(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
        message: exception.serverErrorMessageModel.message,
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
      ));
    }
  }
}
