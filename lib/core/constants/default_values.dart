import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_entitie.dart';
import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_userinfo_entity.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/models/active_room_user_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_entity.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/admin_entity.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/join_create_room_entity.dart';
import 'package:equatable/equatable.dart';

import '../../features/Rooms/domain/entities/audience_entity.dart';
import '../../features/Rooms/domain/entities/brodcasters_entity.dart';
import '../../features/Rooms/domain/entities/me_entity.dart';
import '../../features/UserProfile/data/models/my_podcast_data_model.dart';
import 'base_podcast_entitie/base_podcast_audio_info.dart';

class DefaultsValues extends Equatable {
  static const JoinCreateRoomEntity joinCreateRoomEntitieDefault =
      JoinCreateRoomEntity(
          roomName: '',
          roomType: '',
          isRecording: false,
          roomCategory: '',
          appId: '',
          createdAt: '',
          userToken: '',
          roomId: '');
  static const ActiveRoomUserDataEntity activeRoomUserDataEntitieDefault =
      ActiveRoomUserModel(
          askedToSpeak: false,
          isSpeaking: false,
          iMuteHim: false,
          id: '',
          name: '',
          isMutted: false,
          photo: '',
          uid: -1);
  static const AdminEntity adminEntitieDefault =
      AdminEntity(activeRoomUserDataEntitieDefault);

  static const MeEntity meEntitieDefault =
      MeEntity(activeRoomUserDataEntitieDefault);
  static const AudienceEntity audienceEntitieDefault = AudienceEntity([]);
  static const BrodcastersEntity broadCastersEntitieDefault =
      BrodcastersEntity([]);
  static const BasePodcastEntitie basePodcastEntitieDefaultValues =
      MyPodcastsDataModel(
          podcastId: '',
          podcastName: '',
          podcastLikesCount: 0,
          category: '',
          createdAt: '',
          isLiked: false,
          podcastUserInfo: PodcastUserInfoEntity('', '', ''),
          podcastInfo: PodcastAudioInoEntitie(
            0,
            '',
          ));
  @override
  List<Object?> get props => [
        joinCreateRoomEntitieDefault,
        adminEntitieDefault,
        meEntitieDefault,
        audienceEntitieDefault,
        broadCastersEntitieDefault,
        activeRoomUserDataEntitieDefault,
        basePodcastEntitieDefaultValues,
      ];
}
