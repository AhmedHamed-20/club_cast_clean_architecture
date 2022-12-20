import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AccessTokenCacheUsecase
    extends BaseUsecase<bool, AccessTokenCacheParams> {
  final BaseAuthRepository baseAuthRepository;

  AccessTokenCacheUsecase(this.baseAuthRepository);
  @override
  Future<Either<Failure, bool>> call(AccessTokenCacheParams params) async {
    return await baseAuthRepository.cacheAccessToken(params);
  }
}

class AccessTokenCacheParams extends Equatable {
  final String accessToken;

  const AccessTokenCacheParams(this.accessToken);

  @override
  List<Object?> get props => [accessToken];
}
