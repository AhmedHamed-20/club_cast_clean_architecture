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
  final bool isEndOfFollowersData;
  final bool isEndOfFollowingData;
  const OtherUserProfileState(
      {this.otherUserDataEntitie,
      this.errorMessage = '',
      this.statusCode = 0,
      this.isEndOfFollowersData = false,
      this.isEndOfFollowingData = false,
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
    bool? isEndOfFollowersData,
    bool? isEndOfFollowingData,
    String? errorMessage,
    int? statusCode,
    UserDataGetRequestStatus? userDataGetRequestStatus,
  }) {
    return OtherUserProfileState(
      isEndOfFollowersData: isEndOfFollowersData ?? this.isEndOfFollowersData,
      isEndOfFollowingData: isEndOfFollowingData ?? this.isEndOfFollowingData,
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
        isEndOfFollowersData,
        isEndOfFollowingData,
        otherUserDataEntitie,
        errorMessage,
        statusCode,
        userDataGetRequestStatus,
        otherUserFollowersFollowingDataEntitie,
        followersFollowingDataGetRequestStatus,
      ];
}
