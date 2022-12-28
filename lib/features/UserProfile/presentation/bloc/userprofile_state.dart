part of 'userprofile_bloc.dart';

class UserprofileState extends Equatable {
  final List<MyPodcastEntite> myPodcastEntite;
  final String errorMessage;
  final MyPodCastRequestStatus myPodCastequestStatus;
  final UpdatedUserDataInfoEntitie? updatedUserDataInfoEntitie;
  final UpdateUserDataRequestStatus updateUserDataRequestStatus;
  final UploadPodcastRequestStatus uploadPodcastRequestStatus;
  final UpdateUserDataRequestStatus updatePasswordRequestStatus;
  final EventCreateRequestStatus eventCreateRequestStatus;
  final List<MyEventEntitie> myEvents;
  final UserDataGetRequestStatus myEventRequestStatus;
  final UserDataGetRequestStatus getMyFollowersRequestStatus;
  final OtherUsersDataEntitie? followersData;
  final OtherUsersDataEntitie? followingData;
  final UserDataGetRequestStatus getMyFollowingRequestStatus;
  final BackGroundColorGenerateRequestStatus
      backGroundColorGenerateRequestStatus;
  final List<PaletteColor> backGroundColors;
  const UserprofileState(
      {this.myPodcastEntite = const [],
      this.updatedUserDataInfoEntitie,
      this.backGroundColors = const [],
      this.followersData,
      this.followingData,
      this.getMyFollowersRequestStatus = UserDataGetRequestStatus.loading,
      this.getMyFollowingRequestStatus = UserDataGetRequestStatus.loading,
      this.backGroundColorGenerateRequestStatus =
          BackGroundColorGenerateRequestStatus.loading,
      this.myEventRequestStatus = UserDataGetRequestStatus.loading,
      this.myEvents = const [],
      this.eventCreateRequestStatus = EventCreateRequestStatus.idle,
      this.uploadPodcastRequestStatus = UploadPodcastRequestStatus.idle,
      this.updateUserDataRequestStatus = UpdateUserDataRequestStatus.idle,
      this.errorMessage = '',
      this.updatePasswordRequestStatus = UpdateUserDataRequestStatus.idle,
      this.myPodCastequestStatus = MyPodCastRequestStatus.loading});

  UserprofileState copyWith({
    OtherUsersDataEntitie? followersData,
    OtherUsersDataEntitie? followingData,
    UserDataGetRequestStatus? getMyFollowersRequestStatus,
    UserDataGetRequestStatus? getMyFollowingRequestStatus,
    List<PaletteColor>? backGroundColors,
    BackGroundColorGenerateRequestStatus? backGroundColorGenerateRequestStatus,
    UserDataGetRequestStatus? myEventRequestStatus,
    List<MyEventEntitie>? myEvents,
    EventCreateRequestStatus? eventCreateRequestStatus,
    UpdateUserDataRequestStatus? updatePasswordRequestStatus,
    UploadPodcastRequestStatus? uploadPodcastRequestStatus,
    UpdatedUserDataInfoEntitie? updatedUserDataInfoEntitie,
    UpdateUserDataRequestStatus? updateUserDataRequestStatus,
    List<MyPodcastEntite>? myPodcastEntite,
    String? errorMessage,
    MyPodCastRequestStatus? myPodCastequestStatus,
  }) {
    return UserprofileState(
      followersData: followersData ?? this.followersData,
      followingData: followingData ?? this.followingData,
      getMyFollowersRequestStatus:
          getMyFollowersRequestStatus ?? this.getMyFollowersRequestStatus,
      getMyFollowingRequestStatus:
          getMyFollowingRequestStatus ?? this.getMyFollowingRequestStatus,
      backGroundColors: backGroundColors ?? this.backGroundColors,
      backGroundColorGenerateRequestStatus:
          backGroundColorGenerateRequestStatus ??
              this.backGroundColorGenerateRequestStatus,
      myEventRequestStatus: myEventRequestStatus ?? this.myEventRequestStatus,
      myEvents: myEvents ?? this.myEvents,
      eventCreateRequestStatus:
          eventCreateRequestStatus ?? this.eventCreateRequestStatus,
      updatePasswordRequestStatus:
          updatePasswordRequestStatus ?? this.updatePasswordRequestStatus,
      uploadPodcastRequestStatus:
          uploadPodcastRequestStatus ?? this.uploadPodcastRequestStatus,
      updateUserDataRequestStatus:
          updateUserDataRequestStatus ?? this.updateUserDataRequestStatus,
      updatedUserDataInfoEntitie:
          updatedUserDataInfoEntitie ?? this.updatedUserDataInfoEntitie,
      myPodcastEntite: myPodcastEntite ?? this.myPodcastEntite,
      errorMessage: errorMessage ?? this.errorMessage,
      myPodCastequestStatus:
          myPodCastequestStatus ?? this.myPodCastequestStatus,
    );
  }

  @override
  List<Object?> get props => [
        myPodCastequestStatus,
        myEventRequestStatus,
        myEvents,
        followersData,
        followingData,
        getMyFollowersRequestStatus,
        getMyFollowingRequestStatus,
        backGroundColors,
        backGroundColorGenerateRequestStatus,
        eventCreateRequestStatus,
        updatePasswordRequestStatus,
        myPodcastEntite,
        errorMessage,
        updateUserDataRequestStatus,
        updatedUserDataInfoEntitie,
        uploadPodcastRequestStatus,
      ];
}
