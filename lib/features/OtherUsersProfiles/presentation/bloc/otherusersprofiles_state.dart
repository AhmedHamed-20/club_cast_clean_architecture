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
  final OtherUserPodcastEntitie? otherUserPodcastEntitie;
  final UserDataGetRequestStatus otherUserPodcastGetRequestStatus;
  final bool isEndOfPodcastData;

  const OtherUserProfileState(
      {this.otherUserDataEntitie,
      this.errorMessage = '',
      this.statusCode = 0,
      this.isEndOfPodcastData = false,
      this.otherUserPodcastEntitie,
      this.otherUserPodcastGetRequestStatus = UserDataGetRequestStatus.loading,
      this.isEndOfFollowersData = false,
      this.isEndOfFollowingData = false,
      this.followersFollowingDataGetRequestStatus =
          FollowersFollowingDataGetRequestStatus.loading,
      this.otherUserFollowersFollowingDataEntitie,
      this.userDataGetRequestStatus = UserDataGetRequestStatus.loading});

  OtherUserProfileState copyWith({
    bool? isEndOfPodcastData,
    OtherUserPodcastEntitie? otherUserPodcastEntitie,
    UserDataGetRequestStatus? otherUserPodcastGetRequestStatus,
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
      otherUserPodcastEntitie:
          otherUserPodcastEntitie ?? this.otherUserPodcastEntitie,
      otherUserPodcastGetRequestStatus: otherUserPodcastGetRequestStatus ??
          this.otherUserPodcastGetRequestStatus,
      isEndOfPodcastData: isEndOfPodcastData ?? this.isEndOfPodcastData,
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
        otherUserPodcastEntitie,
        otherUserPodcastGetRequestStatus,
        isEndOfPodcastData,
      ];
}
