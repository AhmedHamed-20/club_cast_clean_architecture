import 'package:club_cast_clean_architecture/core/constants/base_room_user_data_enitie/base_room_user_data_entitie.dart';

class ActiveRoomUserDataEntitie extends BaseRoomUserDataEntitie {
  final bool askedToSpeak;
  final bool isMutted;
  final bool iMuteHim;
  final bool isSpeaking;
  const ActiveRoomUserDataEntitie(
      {required super.id,
      required super.name,
      required super.photo,
      required super.uid,
      required this.askedToSpeak,
      required this.isMutted,
      required this.iMuteHim,
      required this.isSpeaking});

  ActiveRoomUserDataEntitie copyWith(
      {String? id,
      String? name,
      String? photo,
      int? uid,
      bool? askedToSpeak,
      bool? isMutted,
      bool? iMuteHim,
      bool? isSpeaking}) {
    return ActiveRoomUserDataEntitie(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      uid: uid ?? this.uid,
      askedToSpeak: askedToSpeak ?? this.askedToSpeak,
      isMutted: isMutted ?? this.isMutted,
      iMuteHim: iMuteHim ?? this.iMuteHim,
      isSpeaking: isSpeaking ?? this.isSpeaking,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, photo, uid, askedToSpeak, isMutted, iMuteHim, isSpeaking];
}
