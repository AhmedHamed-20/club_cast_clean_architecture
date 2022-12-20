import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/entities/auth_entitie.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/cache_access_token.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/forget_password.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/login.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/sign_up.dart';
import 'package:dartz/dartz.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, AuthEntitie>> signUp(SignUpParams params);
  Future<Either<Failure, AuthEntitie>> login(LoginParams params);
  Future<Either<Failure, bool>> cacheAccessToken(AccessTokenCacheParams params);

  Future<Either<Failure, void>> forgetPassword(ForgetPasswordParams params);
}
