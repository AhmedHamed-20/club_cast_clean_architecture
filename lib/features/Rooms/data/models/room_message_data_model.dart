import 'package:club_cast_clean_architecture/features/Rooms/data/models/all_rooms_user_data.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_message_entity_data.dart';

class RoomMessageDataModel extends RoomMessageDataEntity {
  const RoomMessageDataModel(
      {required super.message,
      required super.isPublic,
      super.messageId,
      super.user,
      super.createdAt,
      super.isMine,
      super.toUserId});

  factory RoomMessageDataModel.fromJson(
      Map<String, dynamic> json, bool isMine) {
    if (json['status'] == 'public') {
      return RoomMessageDataModel(
        message: json['message'],
        messageId: json['_id'],
        isPublic: true,
        isMine: isMine,
        createdAt: json['createdAt'],
        user: RoomsUserDataModel.fromJson(json['user']),
      );
    } else if (json['status'] == 'private') {
      return RoomMessageDataModel(
        message: json['message'],
        messageId: json['_id'],
        isMine: isMine,
        isPublic: false,
        createdAt: json['createdAt'],
        user: RoomsUserDataModel.fromJson(json['user']),
      );
    } else {
      return RoomMessageDataModel(
        message: json['message'],
        messageId: json['_id'],
        isMine: isMine,
        isPublic: true,
        createdAt: json['createdAt'],
        user: RoomsUserDataModel.fromJson(json['user']),
      );
    }
  }

  Map<String, dynamic> toJsonPublicByDefault({
    required bool isPublic,
    String? userId,
  }) {
    if (isPublic) {
      return {
        'message': message,
        'status': 'public',
      };
    } else {
      return {'message': message, 'status': 'private', 'to': userId};
    }
  }
}
