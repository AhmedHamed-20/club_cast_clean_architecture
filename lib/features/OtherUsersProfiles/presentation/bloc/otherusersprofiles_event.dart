part of 'otherusersprofiles_bloc.dart';

abstract class OtherUserProfileEvent extends Equatable {
  const OtherUserProfileEvent();
}

class OtherUserProfileGetEvent extends OtherUserProfileEvent {
  final String accessToken;
  final String userId;

  const OtherUserProfileGetEvent(
      {required this.accessToken, required this.userId});

  @override
  List<Object> get props => [accessToken, userId];
}

class OtherUserFollowersGetEvent extends OtherUserProfileEvent {
  final String accessToken;
  final String userId;

  const OtherUserFollowersGetEvent(
      {required this.accessToken, required this.userId});

  @override
  List<Object> get props => [accessToken, userId];
}

class OtherUserFollowingGetEvent extends OtherUserProfileEvent {
  final String accessToken;
  final String userId;

  const OtherUserFollowingGetEvent(
      {required this.accessToken, required this.userId});

  @override
  List<Object> get props => [accessToken, userId];
}

class OtherUserFollowersGetMoreEvent extends OtherUserProfileEvent {
  final String accessToken;
  final String userId;
  final int page;
  const OtherUserFollowersGetMoreEvent({
    required this.accessToken,
    required this.userId,
    required this.page,
  });

  @override
  List<Object> get props => [
        accessToken,
        userId,
        page,
      ];
}

class OtherUserFollowingGetMoreEvent extends OtherUserProfileEvent {
  final String accessToken;
  final String userId;
  final int page;
  const OtherUserFollowingGetMoreEvent({
    required this.accessToken,
    required this.userId,
    required this.page,
  });

  @override
  List<Object> get props => [
        accessToken,
        userId,
        page,
      ];
}
