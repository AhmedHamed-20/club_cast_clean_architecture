import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/datasources/remote_user_info_data_source_impl.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/models/podcast_upload_model.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_entitie.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/signature_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/create_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/generate_signature.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/upload_podcast.dart';
import 'package:dartz/dartz.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/get_my_podcasts.dart';

class UserInfoRepositoryImpl extends BaseUserInfoRepository {
  final BaseUserInfoRemoteDataSource baseUserInfoRemoteDataSource;

  UserInfoRepositoryImpl(this.baseUserInfoRemoteDataSource);
  @override
  Future<Either<Failure, List<MyPodcastEntite>>> getMyPodcasts(
      MyPodcastGetParams params) async {
    try {
      final result = await baseUserInfoRemoteDataSource.getMyPodcasts(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(
        ServerFailure(
          message: exception.serverErrorMessageModel.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SignatureEntitie>> generateSignature(
      SignatureGenerateParams params) async {
    try {
      final result =
          await baseUserInfoRemoteDataSource.generateSignature(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(
        ServerFailure(
          message: exception.serverErrorMessageModel.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, PodcastUploadModel>> uploadPodcast(
      PodcastUploadParams params) async {
    try {
      final result = await baseUserInfoRemoteDataSource.uploadPodcast(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(
        ServerFailure(
          message: exception.serverErrorMessageModel.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> createPodcast(
      PodcastCreateParams params) async {
    try {
      final result = await baseUserInfoRemoteDataSource.createPodcast(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(
        ServerFailure(
          message: exception.serverErrorMessageModel.message,
        ),
      );
    }
  }
}
