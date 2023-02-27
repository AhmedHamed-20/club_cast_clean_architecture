import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/repositories/base_layout_repository.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetThemeDataValueFromCacheUssecase
    extends BaseUsecase<bool, GetThemeDataValueFromCacheParams> {
  final BaseLayoutRepository baseLayoutRepository;

  GetThemeDataValueFromCacheUssecase(this.baseLayoutRepository);
  @override
  Future<Either<Failure, bool>> call(
      GetThemeDataValueFromCacheParams params) async {
    return await baseLayoutRepository.getCachedThemeDataValue(params);
  }
}

class GetThemeDataValueFromCacheParams extends Equatable {
  final String key;

  const GetThemeDataValueFromCacheParams({
    required this.key,
  });

  @override
  List<Object?> get props => [
        key,
      ];
}
