import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_user_data.dart';

class RoomsUserDataModel extends RoomUserDataEntity {
  const RoomsUserDataModel(
      {required super.id,
      required super.name,
      required super.photo,
      required super.uid});
  factory RoomsUserDataModel.fromJson(Map<String, dynamic> json) {
    return RoomsUserDataModel(
      id: json['_id'],
      name: json['name'],
      photo: (json['photo'] as String).contains('https')
          ? json['photo']
          : EndPoints.socketBaseUrl + json['photo'],
      uid: json['uid'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'photo': photo,
      'uid': uid,
    };
  }

  @override
  List<Object?> get props => [id, name, photo, uid];
}
