import 'package:club_cast_clean_architecture/core/layout/domain/entities/category_info_entity.dart';

class CategoryInfoModel extends CategoryInfoEntity {
  const CategoryInfoModel({
    required super.name,
    required super.id,
  });

  factory CategoryInfoModel.fromJson(Map<String, dynamic> json) {
    return CategoryInfoModel(
      name: json['name'],
      id: json['_id'],
    );
  }
}
