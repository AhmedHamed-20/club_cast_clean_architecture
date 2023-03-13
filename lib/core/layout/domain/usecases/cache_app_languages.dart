import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/base_layout_repository.dart';

class CacheAppLanguageUsecase
    extends BaseUsecase<void, AppLaguagesCacheParams> {
  final BaseLayoutRepository baseLayoutRepository;

  CacheAppLanguageUsecase(this.baseLayoutRepository);
  @override
  Future<Either<Failure, void>> call(AppLaguagesCacheParams params) async {
    return await baseLayoutRepository.cacheAppLanguage(params);
  }
}

class AppLaguagesCacheParams extends Equatable {
  final String key;
  final String value;

  const AppLaguagesCacheParams({required this.key, required this.value});

  @override
  List<Object?> get props => [key, value];
}
