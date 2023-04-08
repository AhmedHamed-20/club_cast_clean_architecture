import '../../../../core/constants/base_room_user_data_entity/base_room_user_data_entity.dart';

abstract class RoomUserDataEntity extends BaseRoomUserDataEntity {
  const RoomUserDataEntity(
      {required super.id,
      required super.name,
      required super.photo,
      required super.uid});
}
