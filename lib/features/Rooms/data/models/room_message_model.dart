import 'package:club_cast_clean_architecture/features/Rooms/data/models/room_message_data_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_message_entitie.dart';

class RoomMessageModel extends RoomMessageEntitie {
  const RoomMessageModel({required super.results, required super.roomMessages});

  factory RoomMessageModel.fromJson(Map<String, dynamic> json) {
    return RoomMessageModel(
      results: json['results'],
      roomMessages: (json['data'] as List)
          .map((e) => RoomMessageDataModel.fromJson(e))
          .toList(),
    );
  }
}
