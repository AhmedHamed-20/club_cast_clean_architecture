import 'package:club_cast_clean_architecture/features/Rooms/data/models/active_room_user_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_enitie.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/admin_entitie.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/join_create_room_entitie.dart';
import 'package:equatable/equatable.dart';

import '../../features/Rooms/domain/entities/audience_entite.dart';
import '../../features/Rooms/domain/entities/brodcasters_entitie.dart';
import '../../features/Rooms/domain/entities/me_entitie.dart';

class DefaultsValues extends Equatable {
  static const JoinCreateRoomEntitie joinCreateRoomEntitieDefault =
      JoinCreateRoomEntitie(
          roomName: '',
          roomType: '',
          isRecording: false,
          roomCategory: '',
          appId: '',
          createdAt: '',
          userToken: '',
          roomId: '');
  static const ActiveRoomUserDataEntitie activeRoomUserDataEntitieDefault =
      ActiveRoomUserModel(
          askedToSpeak: false,
          isSpeaking: false,
          iMuteHim: false,
          id: '',
          name: '',
          isMutted: false,
          photo: '',
          uid: 0);
  static const AdminEntitie adminEntitieDefault =
      AdminEntitie(activeRoomUserDataEntitieDefault);

  static const MeEntitie meEntitieDefault =
      MeEntitie(activeRoomUserDataEntitieDefault);
  static const AudienceEntitie audienceEntitieDefault = AudienceEntitie([]);
  static const BrodcastersEntitie broadCastersEntitieDefault =
      BrodcastersEntitie([]);
  @override
  List<Object?> get props => [
        joinCreateRoomEntitieDefault,
        adminEntitieDefault,
        meEntitieDefault,
        audienceEntitieDefault,
        broadCastersEntitieDefault,
        activeRoomUserDataEntitieDefault,
      ];
}
