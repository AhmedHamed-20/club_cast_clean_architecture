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

  @override
  ActiveRoomUserDataEntitie copyWith(
      {String? id,
      String? name,
      String? photo,
      int? uid,
      bool? askedToSpeak,
      bool? isMutted,
      bool? iMuteHim,
      bool? isSpeaking}) {
    return ActiveRoomUserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        photo: photo ?? this.photo,
        uid: uid ?? this.uid,
        askedToSpeak: askedToSpeak ?? this.askedToSpeak,
        isMutted: isMutted ?? this.isMutted,
        iMuteHim: iMuteHim ?? this.iMuteHim,
        isSpeaking: isSpeaking ?? this.isSpeaking);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'photo': photo,
      'uid': uid,
    };
  }

  @override
  List<Object?> get props =>
      [id, name, photo, uid, askedToSpeak, isMutted, iMuteHim, isSpeaking];
}
