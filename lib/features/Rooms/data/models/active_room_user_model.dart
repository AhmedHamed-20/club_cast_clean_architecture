import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_enitie.dart';

class ActiveRoomUserModel extends ActiveRoomUserDataEntitie {
  const ActiveRoomUserModel(
      {required super.id,
      required super.name,
      required super.photo,
      required super.uid,
      required super.askedToSpeak,
      required super.isMutted,
      required super.iMuteHim,
      required super.isSpeaking});
  factory ActiveRoomUserModel.fromJson(Map<String, dynamic> json) {
    return ActiveRoomUserModel(
      id: json['_id'],
      name: json['name'],
      photo: json['photo'],
      uid: json['uid'],
      askedToSpeak: false,
      isMutted: false,
      iMuteHim: false,
      isSpeaking: false,
    );
  }
}
