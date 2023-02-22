import '../../../../core/constants/base_all_rooms_data_entite/base_all_rooms_data_entitie.dart';

class AllRoomsDataEntitie extends BaseAllRoomsDataEntitie {
  const AllRoomsDataEntitie(
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
