import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_entitie.dart';
import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_userinfo_entite.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/models/active_room_user_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_enitie.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/admin_entitie.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/join_create_room_entitie.dart';
import 'package:equatable/equatable.dart';

import '../../features/Rooms/domain/entities/audience_entite.dart';
import '../../features/Rooms/domain/entities/brodcasters_entitie.dart';
import '../../features/Rooms/domain/entities/me_entitie.dart';
import '../../features/UserProfile/data/models/my_podcast_data_model.dart';
import 'base_podcast_entitie/base_podcast_audio_info.dart';

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
          uid: -1);
  static const AdminEntitie adminEntitieDefault =
      AdminEntitie(activeRoomUserDataEntitieDefault);

  static const MeEntitie meEntitieDefault =
      MeEntitie(activeRoomUserDataEntitieDefault);
  static const AudienceEntitie audienceEntitieDefault = AudienceEntitie([]);
  static const BrodcastersEntitie broadCastersEntitieDefault =
      BrodcastersEntitie([]);
  static const BasePodcastEntitie basePodcastEntitieDefaultValues =
      MyPodcastsDataModel(
          podcastId: '',
          podcastName: '',
          podcastLikesCount: 0,
          category: '',
          createdAt: '',
          isLiked: false,
          podcastUserInfo: PodcastUserInfoEntitie('', '', ''),
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
