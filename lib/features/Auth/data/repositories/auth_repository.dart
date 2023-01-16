import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/entities/auth_entitie.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/repositories/auth_repository.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/cache_access_token.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/forget_password.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/login.dart';
import 'package:dartz/dartz.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/sign_up.dart';

import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImple extends BaseAuthRepository {
  final BaseAuthRemoteDataSource baseAuthRemoteDataSource;
  final BaseAuthLocalDataSource baseAuthLocalDataSource;
  AuthRepositoryImple(
      this.baseAuthRemoteDataSource, this.baseAuthLocalDataSource);
  @override
  Future<Either<Failure, AuthEntitie>> signUp(SignUpParams params) async {
    try {
      final result = await baseAuthRemoteDataSource.signUp(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
        message: exception.serverErrorMessageModel.message,
      ));
    }
  }

  @override
  Future<Either<Failure, AuthEntitie>> login(LoginParams params) async {
    try {
      final result = await baseAuthRemoteDataSource.login(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
        message: exception.serverErrorMessageModel.message,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword(
      ForgetPasswordParams params) async {
    try {
      final result = await baseAuthRemoteDataSource.forgetPassword(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
        message: exception.serverErrorMessageModel.message,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> cacheAccessToken(
      AccessTokenCacheParams params) async {
    try {
      final result = await baseAuthLocalDataSource.cacheAccessToken(params);
      return Right(result);
    } on CacheException catch (exception) {
      return Left(CacheFailure(
          message: exception.localErrorsMessageModel.errorMessage));
    }
  }
}
