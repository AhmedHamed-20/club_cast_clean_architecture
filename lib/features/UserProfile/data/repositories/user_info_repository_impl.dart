import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/datasources/remote_user_info_data_source_impl.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/models/podcast_upload_model.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_event_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_entite.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/other_users_basic_info_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/signature_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/updated_user_data_info.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/create_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/get_my_events.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/remove_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/update_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/get_my_podcasts.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/remove_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/create_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/generate_signature.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/upload_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/get_followers.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_password.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_image.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_info.dart';
import 'package:dartz/dartz.dart';

class UserInfoRepositoryImpl extends BaseUserInfoRepository {
  final BaseUserInfoRemoteDataSource baseUserInfoRemoteDataSource;

  UserInfoRepositoryImpl(this.baseUserInfoRemoteDataSource);
  @override
  Future<Either<Failure, MyPodcastEntitie>> getMyPodcasts(
      MyPodcastGetParams params) async {
    try {
      final result = await baseUserInfoRemoteDataSource.getMyPodcasts(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(
        ServerFailure(
          message: exception.serverErrorMessageModel.message,
          statusCode: exception.serverErrorMessageModel.statusCode,
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
          statusCode: exception.serverErrorMessageModel.statusCode,
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
          statusCode: exception.serverErrorMessageModel.statusCode,
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
          statusCode: exception.serverErrorMessageModel.statusCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UpdatedUserDataInfoEntitie>> updateUserData(
      UserDataUpdateParams params) async {
    try {
      final result = await baseUserInfoRemoteDataSource.updateUserData(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(
        ServerFailure(
          message: exception.serverErrorMessageModel.message,
          statusCode: exception.serverErrorMessageModel.statusCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> updatePassword(
      PasswordUpdateParams params) async {
    try {
      final result = await baseUserInfoRemoteDataSource.updatePassword(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
          message: exception.serverErrorMessageModel.message,
          statusCode: exception.serverErrorMessageModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> createEvent(EventCreateParams params) async {
    try {
      final result = await baseUserInfoRemoteDataSource.createEvent(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
          message: exception.serverErrorMessageModel.message,
          statusCode: exception.serverErrorMessageModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, MyEventsEntitie>> getMyEvents(
      MyEventsParams params) async {
    try {
      final result = await baseUserInfoRemoteDataSource.getMyEvents(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
          message: exception.serverErrorMessageModel.message,
          statusCode: exception.serverErrorMessageModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, OtherUsersDataEntitie>> getFollowers(
      FollowersFollowingParams params) async {
    try {
      final result = await baseUserInfoRemoteDataSource.getFollowers(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
          message: exception.serverErrorMessageModel.message,
          statusCode: exception.serverErrorMessageModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, OtherUsersDataEntitie>> getFollowing(
      FollowersFollowingParams params) async {
    try {
      final result = await baseUserInfoRemoteDataSource.getFollowing(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
          message: exception.serverErrorMessageModel.message,
          statusCode: exception.serverErrorMessageModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> removePodcast(
      PodcastRemoveParams params) async {
    try {
      final result = await baseUserInfoRemoteDataSource.removePodcast(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
          message: exception.serverErrorMessageModel.message,
          statusCode: exception.serverErrorMessageModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> removeEvent(
      EventRemoveUsecaseParams params) async {
    try {
      final result = await baseUserInfoRemoteDataSource.removeEvent(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
          message: exception.serverErrorMessageModel.message,
          statusCode: exception.serverErrorMessageModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> updateEvent(
      EventUpdateUsecaseParams params) async {
    try {
      final result = await baseUserInfoRemoteDataSource.updateEvent(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
          message: exception.serverErrorMessageModel.message,
          statusCode: exception.serverErrorMessageModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserImage(
      UpdateUserImageUsecaseParams params) async {
    try {
      final result = await baseUserInfoRemoteDataSource.updateUserPhoto(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
          message: exception.serverErrorMessageModel.message,
          statusCode: exception.serverErrorMessageModel.statusCode));
    }
  }
}
