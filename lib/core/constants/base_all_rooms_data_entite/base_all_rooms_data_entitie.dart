import 'package:equatable/equatable.dart';

import '../base_room_user_data_enitie/base_room_user_data_entitie.dart';

abstract class BaseAllRoomsDataEntitie extends Equatable {
  final String id;
  final String name;
  final String category;
  final bool isRecording;
  final String createdAt;
  final BaseRoomUserDataEntitie admin;
  final List<BaseRoomUserDataEntitie> audience;
  final List<BaseRoomUserDataEntitie> brodcasters;

  const BaseAllRoomsDataEntitie(
      {required this.id,
      required this.name,
      required this.category,
      required this.isRecording,
      required this.createdAt,
      required this.admin,
      required this.audience,
      required this.brodcasters});
}
