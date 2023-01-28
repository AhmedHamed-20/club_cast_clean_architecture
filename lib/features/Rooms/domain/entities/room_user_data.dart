import '../../../../core/constants/base_room_user_data_enitie/base_room_user_data_entitie.dart';

class RoomUserDataEntitie extends BaseRoomUserDataEntitie {
  const RoomUserDataEntitie(
      {required super.id,
      required super.name,
      required super.photo,
      required super.uid});

  @override
  List<Object?> get props => [id, name, photo, uid];
}
