import 'package:club_cast_clean_architecture/core/constants/base_all_rooms_data_entity/base_all_rooms_data_entity.dart';

abstract class SearchRoomsEntity extends BaseAllRoomsDataEntity {
  const SearchRoomsEntity(
      {required super.id,
      required super.name,
      required super.category,
      required super.isRecording,
      required super.createdAt,
      required super.admin,
      required super.audience,
      required super.brodcasters});

  Map<String, dynamic> toJson();
}
