import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/entities/auth_entitie.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/repositories/auth_repository.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/forget_password.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/login.dart';
import 'package:dartz/dartz.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/sign_up.dart';

class AuthRepositoryImple extends BaseAuthRepository {
  final BaseAuthRemoteDataSource baseAuthRemoteDataSource;

  AuthRepositoryImple(this.baseAuthRemoteDataSource);
  @override
  Future<Either<Failure, AuthEntitie>> signUp(SignUpParams params) async {
    try {
      final result = await baseAuthRemoteDataSource.signUp(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(
          message: exception.serverErrorMessageModel.message,
          statusCode: exception.serverErrorMessageModel.type));
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
          statusCode: exception.serverErrorMessageModel.type));
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
}
