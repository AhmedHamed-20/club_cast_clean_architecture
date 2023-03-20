part of 'otherusersprofiles_bloc.dart';

class OtherUserProfileState extends Equatable {
  final OtherUserDataEntity? otherUserDataEntitie;
  final String errorMessage;
  final int statusCode;
  final UserDataGetRequestStatus userDataGetRequestStatus;
  final OtherUserFollowersFollowingDataEntity?
      otherUserFollowersFollowingDataEntitie;
  final FollowersFollowingDataGetRequestStatus
      followersFollowingDataGetRequestStatus;
  final bool isEndOfFollowersData;
  final bool isEndOfFollowingData;
  final OtherUserPodcastEntity? otherUserPodcastEntitie;
  final UserDataGetRequestStatus otherUserPodcastGetRequestStatus;
  final bool isEndOfPodcastData;
  final FollowUnfollowUserRequestStatus followUnfollowUserRequestStatus;
  final bool isFollowed;
  final OtherUserEventsEntity? otherUserEventsEntitie;
  final UserDataGetRequestStatus otherUserEventsGetRequestStatus;
  final bool isEndOfEventsData;
  const OtherUserProfileState(
      {this.otherUserDataEntitie,
      this.errorMessage = '',
      this.statusCode = 0,
      this.otherUserEventsEntitie,
      this.otherUserEventsGetRequestStatus = UserDataGetRequestStatus.loading,
      this.isEndOfEventsData = false,
      this.isFollowed = false,
      this.followUnfollowUserRequestStatus =
          FollowUnfollowUserRequestStatus.idle,
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
    bool? isFollowed,
    OtherUserEventsEntity? otherUserEventsEntitie,
    UserDataGetRequestStatus? otherUserEventsGetRequestStatus,
    bool? isEndOfEventsData,
    FollowUnfollowUserRequestStatus? followUnfollowUserRequestStatus,
    OtherUserPodcastEntity? otherUserPodcastEntitie,
    UserDataGetRequestStatus? otherUserPodcastGetRequestStatus,
    FollowersFollowingDataGetRequestStatus?
        followersFollowingDataGetRequestStatus,
    OtherUserFollowersFollowingDataEntity?
        otherUserFollowersFollowingDataEntitie,
    OtherUserDataEntity? otherUserDataEntitie,
    bool? isEndOfFollowersData,
    bool? isEndOfFollowingData,
    String? errorMessage,
    int? statusCode,
    UserDataGetRequestStatus? userDataGetRequestStatus,
  }) {
    return OtherUserProfileState(
      otherUserEventsEntitie:
          otherUserEventsEntitie ?? this.otherUserEventsEntitie,
      otherUserEventsGetRequestStatus: otherUserEventsGetRequestStatus ??
          this.otherUserEventsGetRequestStatus,
      isEndOfEventsData: isEndOfEventsData ?? this.isEndOfEventsData,
      isFollowed: isFollowed ?? this.isFollowed,
      followUnfollowUserRequestStatus: followUnfollowUserRequestStatus ??
          this.followUnfollowUserRequestStatus,
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
        otherUserEventsEntitie,
        otherUserEventsGetRequestStatus,
        isEndOfEventsData,
        followUnfollowUserRequestStatus,
        isEndOfFollowersData,
        isEndOfFollowingData,
        isFollowed,
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
