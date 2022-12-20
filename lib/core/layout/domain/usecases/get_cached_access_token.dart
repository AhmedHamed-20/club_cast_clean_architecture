import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/repositories/base_layout_repository.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CachedAccessTokenGetUsecase
    extends BaseUsecase<String, CachedAccessTokenGetParams> {
  final BaseLayoutRepository baseLayoutRepository;

  CachedAccessTokenGetUsecase(this.baseLayoutRepository);
  @override
  Future<Either<Failure, String>> call(
      CachedAccessTokenGetParams params) async {
    return await baseLayoutRepository.getAccessTokenFromCache(params);
  }
}

class CachedAccessTokenGetParams extends Equatable {
  final String key;

  const CachedAccessTokenGetParams(this.key);

  @override
  List<Object?> get props => [key];
}
