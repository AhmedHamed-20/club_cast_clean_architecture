import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/repositories/base_layout_repository.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CachedAccessTokenUpdateUsecase
    extends BaseUsecase<void, CachedAccessTokenUpdateParams> {
  final BaseLayoutRepository baseLayoutRepository;

  CachedAccessTokenUpdateUsecase(this.baseLayoutRepository);
  @override
  Future<Either<Failure, void>> call(
      CachedAccessTokenUpdateParams params) async {
    return await baseLayoutRepository.updateCachedAccessToken(params);
  }
}

class CachedAccessTokenUpdateParams extends Equatable {
  final String key;
  final String value;

  const CachedAccessTokenUpdateParams({
    required this.key,
    required this.value,
  });

  @override
  List<Object?> get props => [key, value];
}
