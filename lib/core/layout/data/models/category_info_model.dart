import 'package:club_cast_clean_architecture/core/layout/domain/entities/category_info_entitie.dart';

class CategoryInfoModel extends CategoryInfoEtitie {
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
