import 'package:equatable/equatable.dart';

class JoinCreateRoomEntitie extends Equatable {
  final String roomName;
  final String roomType;
  final String roomCategory;
  final String appId;
  final String createdAt;
  final String userToken;
  final bool isRecording;

  const JoinCreateRoomEntitie(
      {required this.roomName,
      required this.roomType,
      required this.isRecording,
      required this.roomCategory,
      required this.appId,
      required this.createdAt,
      required this.userToken});

  @override
  List<Object?> get props => [
        roomName,
        roomType,
        roomCategory,
        appId,
        createdAt,
        userToken,
        isRecording
      ];
}
