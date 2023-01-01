import 'package:equatable/equatable.dart';

import 'category_info_entitie.dart';

class CategoryEntitie extends Equatable {
  final int results;
  final List<CategoryInfoEtitie> categories;

  const CategoryEntitie({
    required this.results,
    required this.categories,
  });

  @override
  List<Object?> get props => [results, categories];
}
