import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:club_cast_clean_architecture/features/Search/presentation/bloc/search_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_events_data_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/MyEventsBloc/my_events_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../features/Rooms/domain/entities/room_user_data.dart';
import '../../features/UserProfile/presentation/bloc/MyPodcastBloc/my_podcast_bloc.dart';

class LikesUsersScreenParams extends Equatable {
  final String podcastId;

  const LikesUsersScreenParams({
    required this.podcastId,
  });

  @override
  List<Object?> get props => [podcastId];
}

class MyProfileFollowersFollowingScreenParams extends Equatable {
  final String accessToken;
  final bool isFollowers;
  final UserProfileBloc userprofileBloc;

  const MyProfileFollowersFollowingScreenParams(
      {required this.accessToken,
      required this.isFollowers,
      required this.userprofileBloc});

  @override
  List<Object?> get props => [accessToken, isFollowers, userprofileBloc];
}

class UpdateUserProfileBasicDataScreenParams extends Equatable {
  final UserProfileBloc userprofileBloc;

  const UpdateUserProfileBasicDataScreenParams(this.userprofileBloc);

  @override
  List<Object?> get props => [userprofileBloc];
}

class EditEventScreenParams extends Equatable {
  final MyEventsDataEntitie myEventEntitie;
  final MyEventsBloc myEventsBloc;
  const EditEventScreenParams(this.myEventEntitie, this.myEventsBloc);

  @override
  List<Object?> get props => [myEventEntitie, myEventsBloc];
}

class CreateEventScreenParams extends Equatable {
  final MyEventsBloc myEventsBloc;
  const CreateEventScreenParams(this.myEventsBloc);

  @override
  List<Object?> get props => [myEventsBloc];
}

class UploadPodcastScreenParams extends Equatable {
  final MyPodcastBloc myPodcastBloc;
  const UploadPodcastScreenParams(this.myPodcastBloc);

  @override
  List<Object?> get props => [myPodcastBloc];
}

class OtherUserProfileScreenParams extends Equatable {
  final String userId;

  const OtherUserProfileScreenParams(
    this.userId,
  );

  @override
  List<Object?> get props => [
        userId,
      ];
}

class OtherUserFollowersFollowingScreenParams extends Equatable {
  final String userId;
  final bool isFollwers;
  final OtherUserProfileBloc otherUserProfileBloc;

  const OtherUserFollowersFollowingScreenParams(
      {required this.userId,
      required this.isFollwers,
      required this.otherUserProfileBloc});

  @override
  List<Object?> get props => [userId, isFollwers, otherUserProfileBloc];
}

class RoomScreenParams extends Equatable {
  final SocketsVoiceBloc socketsBloc;

  const RoomScreenParams(this.socketsBloc);

  @override
  List<Object?> get props => [socketsBloc];
}

class CreateRoomParams extends Equatable {
  final String roomName;
  final String category;
  final bool isRecording;
  final String status;

  const CreateRoomParams(
      {required this.roomName,
      required this.category,
      required this.isRecording,
      required this.status});

  @override
  List<Object?> get props => [roomName, category, isRecording, status];
}

class PodcastCardCallBacksParams extends Equatable {
  final VoidCallback? onPressedOnRemove;
  final VoidCallback onPressedOnCard;
  final VoidCallback onPressedOnUserPhoto;
  final VoidCallback onPressedDownload;
  final VoidCallback onPressedPlay;
  final VoidCallback onPressedOnLikesCount;

  const PodcastCardCallBacksParams(
      {this.onPressedOnRemove,
      required this.onPressedOnCard,
      required this.onPressedOnUserPhoto,
      required this.onPressedDownload,
      required this.onPressedPlay,
      required this.onPressedOnLikesCount});

  @override
  List<Object?> get props => [
        onPressedOnRemove,
        onPressedOnCard,
        onPressedOnUserPhoto,
        onPressedDownload,
        onPressedPlay,
        onPressedOnLikesCount
      ];
}

class PrivateChatRoomScreenParams extends Equatable {
  final RoomUserDataEntitie roomUserDataEntitie;

  const PrivateChatRoomScreenParams({required this.roomUserDataEntitie});

  @override
  List<Object?> get props => [roomUserDataEntitie];
}

class AllPodcastsScreenParams extends Equatable {
  final SearchBloc searchBloc;

  const AllPodcastsScreenParams(this.searchBloc);

  @override
  List<Object?> get props => [searchBloc];
}
