import 'package:equatable/equatable.dart';

import 'category_info_entity.dart';

class CategoryEntity extends Equatable {
  final int results;
  final List<CategoryInfoEntity> categories;

  const CategoryEntity({
    required this.results,
    required this.categories,
  });

  @override
  List<Object?> get props => [results, categories];
}
