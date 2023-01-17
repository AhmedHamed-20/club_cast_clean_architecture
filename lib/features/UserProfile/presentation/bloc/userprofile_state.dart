part of 'userprofile_bloc.dart';

class UserProfileState extends Equatable {
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
  final bool isEndOfFollowersData;
  final bool isEndOfFollowingData;
  final MyDataRemoveRequestStatus myPodCastRemoveRequestStatus;
  final MyDataRemoveRequestStatus myEventRemoveRequestStatus;
  final MyDataUpdateRequestStatus myEventUpdateRequestStatus;
  final String pickedPodcastFilePath;
  final String pickedUserProfileImageFilePath;
  final UpdateUserDataRequestStatus updateUserPhotoRequestStatus;
  final String newToken;
  const UserProfileState(
      {this.myPodcastEntite = const [],
      this.updatedUserDataInfoEntitie,
      this.newToken = '',
      this.backGroundColors = const [],
      this.updateUserPhotoRequestStatus = UpdateUserDataRequestStatus.idle,
      this.pickedUserProfileImageFilePath = '',
      this.myEventRemoveRequestStatus = MyDataRemoveRequestStatus.idle,
      this.myEventUpdateRequestStatus = MyDataUpdateRequestStatus.idle,
      this.myPodCastRemoveRequestStatus = MyDataRemoveRequestStatus.idle,
      this.followersData,
      this.pickedPodcastFilePath = '',
      this.followingData,
      this.isEndOfFollowersData = false,
      this.isEndOfFollowingData = false,
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

  UserProfileState copyWith({
    UpdateUserDataRequestStatus? updateUserPhotoRequestStatus,
    String? pickedPodcastFilePath,
    MyDataRemoveRequestStatus? myEventRemoveRequestStatus,
    MyDataUpdateRequestStatus? myEventUpdateRequestStatus,
    MyDataRemoveRequestStatus? myPodCastRemoveRequestStatus,
    OtherUsersDataEntitie? followersData,
    bool? isEndOfFollowersData,
    bool? isEndOfFollowingData,
    String? newToken,
    String? pickedUserProfileImageFilePath,
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
    return UserProfileState(
      newToken: newToken ?? this.newToken,
      updateUserPhotoRequestStatus:
          updateUserPhotoRequestStatus ?? this.updateUserPhotoRequestStatus,
      pickedUserProfileImageFilePath:
          pickedUserProfileImageFilePath ?? this.pickedUserProfileImageFilePath,
      pickedPodcastFilePath:
          pickedPodcastFilePath ?? this.pickedPodcastFilePath,
      myEventRemoveRequestStatus:
          myEventRemoveRequestStatus ?? this.myEventRemoveRequestStatus,
      myEventUpdateRequestStatus:
          myEventUpdateRequestStatus ?? this.myEventUpdateRequestStatus,
      myPodCastRemoveRequestStatus:
          myPodCastRemoveRequestStatus ?? this.myPodCastRemoveRequestStatus,
      isEndOfFollowersData: isEndOfFollowersData ?? this.isEndOfFollowersData,
      isEndOfFollowingData: isEndOfFollowingData ?? this.isEndOfFollowingData,
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
        myEventRemoveRequestStatus,
        updateUserPhotoRequestStatus,
        myEventUpdateRequestStatus,
        myPodCastRemoveRequestStatus,
        myPodCastequestStatus,
        myEventRequestStatus,
        myEvents,
        newToken,
        pickedPodcastFilePath,
        followersData,
        followingData,
        pickedUserProfileImageFilePath,
        isEndOfFollowersData,
        isEndOfFollowingData,
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
