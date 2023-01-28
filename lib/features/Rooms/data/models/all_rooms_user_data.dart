import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_user_data.dart';

class RoomsUserDataModel extends RoomUserDataEntitie {
  const RoomsUserDataModel(
      {required super.id,
      required super.name,
      required super.photo,
      required super.uid});
  factory RoomsUserDataModel.fromJson(Map<String, dynamic> json) {
    return RoomsUserDataModel(
      id: json['_id'],
      name: json['name'],
      photo: json['photo'],
      uid: json['uid'],
    );
  }
}
