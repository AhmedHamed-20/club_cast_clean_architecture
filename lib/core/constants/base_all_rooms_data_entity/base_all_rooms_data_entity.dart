import 'package:equatable/equatable.dart';

import '../base_room_user_data_entity/base_room_user_data_entity.dart';

abstract class BaseAllRoomsDataEntity extends Equatable {
  final String id;
  final String name;
  final String category;
  final bool isRecording;
  final String createdAt;
  final BaseRoomUserDataEntity admin;
  final List<BaseRoomUserDataEntity> audience;
  final List<BaseRoomUserDataEntity> brodcasters;

  const BaseAllRoomsDataEntity(
      {required this.id,
      required this.name,
      required this.category,
      required this.isRecording,
      required this.createdAt,
      required this.admin,
      required this.audience,
      required this.brodcasters});
}
