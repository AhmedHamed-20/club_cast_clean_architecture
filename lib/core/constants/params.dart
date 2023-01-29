import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/sockets_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../features/UserProfile/domain/entities/my_event_entitie.dart';

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
  final MyEventEntitie myEventEntitie;
  final UserProfileBloc userprofileBloc;
  const EditEventScreenParams(this.myEventEntitie, this.userprofileBloc);

  @override
  List<Object?> get props => [myEventEntitie, userprofileBloc];
}

class CreateEventScreenParams extends Equatable {
  final UserProfileBloc userprofileBloc;
  const CreateEventScreenParams(this.userprofileBloc);

  @override
  List<Object?> get props => [userprofileBloc];
}

class UploadPodcastScreenParams extends Equatable {
  final UserProfileBloc userprofileBloc;
  const UploadPodcastScreenParams(this.userprofileBloc);

  @override
  List<Object?> get props => [userprofileBloc];
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
  final SocketsBloc socketsBloc;

  const RoomScreenParams(this.socketsBloc);

  @override
  List<Object?> get props => [socketsBloc];
}
