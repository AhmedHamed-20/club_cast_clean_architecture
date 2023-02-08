import 'package:club_cast_clean_architecture/core/constants/base_room_user_data_enitie/base_room_user_data_entitie.dart';

abstract class ActiveRoomUserDataEntitie extends BaseRoomUserDataEntitie {
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
      bool? isSpeaking});
}
