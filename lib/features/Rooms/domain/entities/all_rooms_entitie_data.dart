import 'package:equatable/equatable.dart';

import 'base_room_user_data.dart';

class AllRoomsDataEntitie extends Equatable {
  final String id;
  final String name;
  final String category;
  final bool isRecording;
  final String createdAt;
  final RoomUserDataEntitie admin;
  final List<RoomUserDataEntitie> audience;
  final List<RoomUserDataEntitie> brodcasters;

  const AllRoomsDataEntitie(
      {required this.id,
      required this.name,
      required this.category,
      required this.isRecording,
      required this.createdAt,
      required this.admin,
      required this.audience,
      required this.brodcasters});

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
