import '../../../../core/constants/base_room_user_data_entity/base_room_user_data_entity.dart';

class RoomUserDataEntity extends BaseRoomUserDataEntity {
  const RoomUserDataEntity(
      {required super.id,
      required super.name,
      required super.photo,
      required super.uid});

  @override
  List<Object?> get props => [id, name, photo, uid];
}
