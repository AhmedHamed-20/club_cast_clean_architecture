import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/datasources/pdocast_remote_data_source.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_likes_users_entitie.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/repositories/podcast_repository.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/download_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_more_my_following_podcasts.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_podcast_likes_users.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/remove_like_by_podcast_id.dart';
import 'package:dartz/dartz.dart';

class PodcastRepositoryImple extends BasePodcastRepository {
  final BasePodcastRemoteDataSource basePodcastRemoteDataSource;

  PodcastRepositoryImple(this.basePodcastRemoteDataSource);
  @override
  Future<Either<Failure, PodcastEntitie>> getMyFollowingPodcast(
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

  @override
  Future<Either<Failure, PodcastEntitie>> getMoreMyFollowingPodcast(
      MoreMyFollowingPodcastParams params) async {
    try {
      final result =
          await basePodcastRemoteDataSource.getMoreMyFollowingPodcasts(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(
          ServerFailure(message: exception.serverErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> downloadPodcast(
      PodcastDownloadParams params) async {
    try {
      final result = await basePodcastRemoteDataSource.downloadPodcast(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(
          ServerFailure(message: exception.serverErrorMessageModel.message));
    }
  }
}
