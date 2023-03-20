import '../../../../core/constants/base_all_rooms_data_entity/base_all_rooms_data_entity.dart';

class AllRoomsDataEntity extends BaseAllRoomsDataEntity {
  const AllRoomsDataEntity(
      {required super.id,
      required super.name,
      required super.category,
      required super.isRecording,
      required super.createdAt,
      required super.admin,
      required super.audience,
      required super.brodcasters});

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        isRecording,
        createdAt,
        admin,
        audience,
        brodcasters
      ];
}
