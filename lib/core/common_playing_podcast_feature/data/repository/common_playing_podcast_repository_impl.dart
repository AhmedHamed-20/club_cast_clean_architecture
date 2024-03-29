import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/data/datasource/remote_data_source_common_playing_podcast.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/data/models/podcast_likes_users_info_model.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/repository/base_commo_podcast_repository.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/usecases/download_podcast.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/usecases/get_podcast_likes_users.dart';

import '../../domain/usecases/add_like.dart';
import '../../domain/usecases/remove_like.dart';

class CommonPlayingPodcastRepositoryImpl extends BaseCommonPodcastRepository {
  final BaseCommonPlayingPodcastDataSource baseCommonPlayingPodcastDataSource;

  CommonPlayingPodcastRepositoryImpl(this.baseCommonPlayingPodcastDataSource);
  @override
  Future<Either<Failure, List<PodcastLikesUsersInfoModel>>>
      getPodcastLikesUsers(PodcastLikesUsersparams params) async {
    try {
      final result =
          await baseCommonPlayingPodcastDataSource.getPodcastLikesUsers(params);
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
      final result =
          await baseCommonPlayingPodcastDataSource.downloadPodcast(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(
          ServerFailure(message: exception.serverErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> addLikeToPodcast(
      LikeAddMyPodcastsParams params) async {
    try {
      final result = await baseCommonPlayingPodcastDataSource.addLike(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
          message: exception.serverErrorMessageModel.message,
          statusCode: exception.serverErrorMessageModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> removeLike(
      LikeRemoveMyPodcastsParams params) async {
    try {
      final result =
          await baseCommonPlayingPodcastDataSource.removeLike(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
          message: exception.serverErrorMessageModel.message,
          statusCode: exception.serverErrorMessageModel.statusCode));
    }
  }
}
