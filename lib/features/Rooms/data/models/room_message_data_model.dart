import 'package:club_cast_clean_architecture/features/Rooms/data/models/all_rooms_user_data.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_message_entitie_data.dart';

class RoomMessageDataModel extends RoomMessageDataEntitie {
  const RoomMessageDataModel(
      {required super.message,
      required super.isPublic,
      super.user,
      super.toUserId});

  factory RoomMessageDataModel.fromJson(Map<String, dynamic> json) {
    if (json['status'] == 'public') {
      return RoomMessageDataModel(
        message: json['message'],
        isPublic: true,
        user: RoomsUserDataModel.fromJson(json['user']),
      );
    } else if (json['status'] == 'private') {
      return RoomMessageDataModel(
        message: json['message'],
        isPublic: false,
        user: RoomsUserDataModel.fromJson(json['user']),
      );
    } else {
      return RoomMessageDataModel(
        message: json['message'],
        isPublic: true,
        user: RoomsUserDataModel.fromJson(json['user']),
      );
    }
  }

  Map<String, dynamic> toJsonPublicByDefault({
    bool? isPublic = true,
    String? userId,
  }) {
    if (isPublic!) {
      return {
        'message': message,
        'statuse': 'public',
      };
    } else {
      return {'message': message, 'statuse': 'private', 'to': userId};
    }
  }
}
