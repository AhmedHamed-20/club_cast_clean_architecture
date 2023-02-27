import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/repositories/base_layout_repository.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ThemeDataValueCacheUssecase
    extends BaseUsecase<void, ThemeDataValueCacheParams> {
  final BaseLayoutRepository baseLayoutRepository;

  ThemeDataValueCacheUssecase(this.baseLayoutRepository);
  @override
  Future<Either<Failure, void>> call(ThemeDataValueCacheParams params) async {
    return await baseLayoutRepository.cacheThemeDataValue(params);
  }
}

class ThemeDataValueCacheParams extends Equatable {
  final String key;
  final bool isDark;

  const ThemeDataValueCacheParams({required this.key, required this.isDark});

  @override
  List<Object?> get props => [key, isDark];
}
