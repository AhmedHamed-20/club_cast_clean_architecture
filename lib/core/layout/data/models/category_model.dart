import 'package:club_cast_clean_architecture/core/layout/domain/entities/category_entitie.dart';

import 'category_info_model.dart';

class CategoryModel extends CategoryEntitie {
  const CategoryModel({
    required super.results,
    required super.categories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      results: json['results'],
      categories: (json['data']['data'] as List)
          .map((e) => CategoryInfoModel.fromJson(e))
          .toList(),
    );
  }
}
