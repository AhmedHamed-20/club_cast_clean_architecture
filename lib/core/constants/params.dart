import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:equatable/equatable.dart';

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
  final UserprofileBloc userprofileBloc;

  const MyProfileFollowersFollowingScreenParams(
      {required this.accessToken,
      required this.isFollowers,
      required this.userprofileBloc});

  @override
  List<Object?> get props => [accessToken, isFollowers, userprofileBloc];
}
