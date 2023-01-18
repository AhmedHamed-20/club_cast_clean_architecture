part of 'otherusersprofiles_bloc.dart';

class OtherUserProfileState extends Equatable {
  final OtherUserDataEntitie? otherUserDataEntitie;
  final String errorMessage;
  final int statusCode;
  final UserDataGetRequestStatus userDataGetRequestStatus;
  final OtherUserFollowersFollowingDataEntitie?
      otherUserFollowersFollowingDataEntitie;
  final FollowersFollowingDataGetRequestStatus
      followersFollowingDataGetRequestStatus;
  const OtherUserProfileState(
      {this.otherUserDataEntitie,
      this.errorMessage = '',
      this.statusCode = 0,
      this.followersFollowingDataGetRequestStatus =
          FollowersFollowingDataGetRequestStatus.loading,
      this.otherUserFollowersFollowingDataEntitie,
      this.userDataGetRequestStatus = UserDataGetRequestStatus.loading});

  OtherUserProfileState copyWith({
    FollowersFollowingDataGetRequestStatus?
        followersFollowingDataGetRequestStatus,
    OtherUserFollowersFollowingDataEntitie?
        otherUserFollowersFollowingDataEntitie,
    OtherUserDataEntitie? otherUserDataEntitie,
    String? errorMessage,
    int? statusCode,
    UserDataGetRequestStatus? userDataGetRequestStatus,
  }) {
    return OtherUserProfileState(
      otherUserFollowersFollowingDataEntitie:
          otherUserFollowersFollowingDataEntitie ??
              this.otherUserFollowersFollowingDataEntitie,
      followersFollowingDataGetRequestStatus:
          followersFollowingDataGetRequestStatus ??
              this.followersFollowingDataGetRequestStatus,
      otherUserDataEntitie: otherUserDataEntitie ?? this.otherUserDataEntitie,
      errorMessage: errorMessage ?? this.errorMessage,
      statusCode: statusCode ?? this.statusCode,
      userDataGetRequestStatus:
          userDataGetRequestStatus ?? this.userDataGetRequestStatus,
    );
  }

  @override
  List<Object?> get props => [
        otherUserDataEntitie,
        errorMessage,
        statusCode,
        userDataGetRequestStatus,
        otherUserFollowersFollowingDataEntitie,
        followersFollowingDataGetRequestStatus,
      ];
}
