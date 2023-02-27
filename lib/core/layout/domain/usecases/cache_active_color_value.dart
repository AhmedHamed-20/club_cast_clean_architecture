import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/repositories/base_layout_repository.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CacheAppColorValueUsecase
    extends BaseUsecase<void, CacheAppColorsParams> {
  final BaseLayoutRepository baseLayoutRepository;

  CacheAppColorValueUsecase(this.baseLayoutRepository);
  @override
  Future<Either<Failure, void>> call(CacheAppColorsParams params) async {
    return await baseLayoutRepository.cacheAppColorDataValue(params);
  }
}

class CacheAppColorsParams extends Equatable {
  final String key;
  final String color;

  const CacheAppColorsParams({required this.key, required this.color});

  @override
  List<Object?> get props => [key, color];
}
