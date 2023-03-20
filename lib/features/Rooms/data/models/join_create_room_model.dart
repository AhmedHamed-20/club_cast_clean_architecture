import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/join_create_room_entity.dart';

class JoinCreateRooModel extends JoinCreateRoomEntity {
  const JoinCreateRooModel(
      {required super.roomName,
      required super.roomType,
      required super.roomCategory,
      required super.appId,
      required super.createdAt,
      required super.isRecording,
      required super.roomId,
      required super.userToken});

  factory JoinCreateRooModel.fromJson(List<dynamic> json) {
    return JoinCreateRooModel(
      roomName: json[1]['name'],
      roomId: json[1]['_id'],
      roomType: json[1]['status'],
      isRecording: json[1]['isRecording'],
      roomCategory: json[1]['category'],
      appId: json[1]['APP_ID'],
      createdAt: json[1]['createdAt'],
      userToken: json[2],
    );
  }
}
