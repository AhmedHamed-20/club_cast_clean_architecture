import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/repositories/base_layout_repository.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/category_entity.dart';

class CategoriesGetUsecase extends BaseUsecase<CategoryEntity, NoParams> {
  final BaseLayoutRepository baseLayoutRepository;

  CategoriesGetUsecase(this.baseLayoutRepository);
  @override
  Future<Either<Failure, CategoryEntity>> call(NoParams params) async {
    return await baseLayoutRepository.getCategories(params);
  }
}
