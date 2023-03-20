import 'package:club_cast_clean_architecture/core/constants/base_room_user_data_entity/base_room_user_data_entity.dart';

abstract class ActiveRoomUserDataEntity extends BaseRoomUserDataEntity {
  final bool askedToSpeak;
  final bool isMutted;
  final bool iMuteHim;
  final bool isSpeaking;
  const ActiveRoomUserDataEntity(
      {required super.id,
      required super.name,
      required super.photo,
      required super.uid,
      required this.askedToSpeak,
      required this.isMutted,
      required this.iMuteHim,
      required this.isSpeaking});

  ActiveRoomUserDataEntity copyWith(
      {String? id,
      String? name,
      String? photo,
      int? uid,
      bool? askedToSpeak,
      bool? isMutted,
      bool? iMuteHim,
      bool? isSpeaking});
}
