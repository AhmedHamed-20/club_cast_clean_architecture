import 'package:equatable/equatable.dart';

class JoinCreateRoomEntity extends Equatable {
  final String roomName;
  final String roomType;
  final String roomCategory;
  final String appId;
  final String createdAt;
  final String userToken;
  final bool isRecording;
  final String roomId;
  const JoinCreateRoomEntity(
      {required this.roomName,
      required this.roomType,
      required this.isRecording,
      required this.roomCategory,
      required this.appId,
      required this.createdAt,
      required this.userToken,
      required this.roomId});

  @override
  List<Object?> get props => [
        roomName,
        roomType,
        roomCategory,
        roomId,
        appId,
        createdAt,
        userToken,
        isRecording
      ];
}
