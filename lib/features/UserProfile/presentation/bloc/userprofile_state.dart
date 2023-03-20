part of 'userprofile_bloc.dart';

class UserProfileState extends Equatable {
  final String errorMessage;
  final bool isPasswordHide;
  final UpdatedUserDataInfoEntity? updatedUserDataInfoEntitie;
  final UpdateUserDataRequestStatus updateUserDataRequestStatus;
  final UpdateUserDataRequestStatus updatePasswordRequestStatus;
  final UserDataGetRequestStatus getMyFollowersRequestStatus;
  final OtherUsersDataEntity? followersData;
  final OtherUsersDataEntity? followingData;
  final UserDataGetRequestStatus getMyFollowingRequestStatus;
  final BackGroundColorGenerateRequestStatus
      backGroundColorGenerateRequestStatus;
  final List<PaletteColor> backGroundColors;
  final bool isEndOfFollowersData;
  final bool isEndOfFollowingData;
  final String pickedUserProfileImageFilePath;
  final UpdateUserDataRequestStatus updateUserPhotoRequestStatus;
  final String newToken;
  final int statusCode;
  const UserProfileState({
    this.updatedUserDataInfoEntitie,
    this.newToken = '',
    this.isPasswordHide = true,
    this.statusCode = 0,
    this.backGroundColors = const [],
    this.updateUserPhotoRequestStatus = UpdateUserDataRequestStatus.idle,
    this.pickedUserProfileImageFilePath = '',
    this.followersData,
    this.followingData,
    this.isEndOfFollowersData = false,
    this.isEndOfFollowingData = false,
    this.getMyFollowersRequestStatus = UserDataGetRequestStatus.loading,
    this.getMyFollowingRequestStatus = UserDataGetRequestStatus.loading,
    this.backGroundColorGenerateRequestStatus =
        BackGroundColorGenerateRequestStatus.loading,
    this.updateUserDataRequestStatus = UpdateUserDataRequestStatus.idle,
    this.errorMessage = '',
    this.updatePasswordRequestStatus = UpdateUserDataRequestStatus.idle,
  });

  UserProfileState copyWith({
    UpdateUserDataRequestStatus? updateUserPhotoRequestStatus,
    OtherUsersDataEntity? followersData,
    bool? isEndOfFollowersData,
    bool? isEndOfFollowingData,
    bool? isEndOfMyPodcastsData,
    String? newToken,
    int? statusCode,
    bool? isPasswordHide,
    String? pickedUserProfileImageFilePath,
    OtherUsersDataEntity? followingData,
    UserDataGetRequestStatus? getMyFollowersRequestStatus,
    UserDataGetRequestStatus? getMyFollowingRequestStatus,
    List<PaletteColor>? backGroundColors,
    BackGroundColorGenerateRequestStatus? backGroundColorGenerateRequestStatus,
    UpdateUserDataRequestStatus? updatePasswordRequestStatus,
    UpdatedUserDataInfoEntity? updatedUserDataInfoEntitie,
    UpdateUserDataRequestStatus? updateUserDataRequestStatus,
    String? errorMessage,
  }) {
    return UserProfileState(
      isPasswordHide: isPasswordHide ?? this.isPasswordHide,
      statusCode: statusCode ?? this.statusCode,
      newToken: newToken ?? this.newToken,
      updateUserPhotoRequestStatus:
          updateUserPhotoRequestStatus ?? this.updateUserPhotoRequestStatus,
      pickedUserProfileImageFilePath:
          pickedUserProfileImageFilePath ?? this.pickedUserProfileImageFilePath,
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
      updatePasswordRequestStatus:
          updatePasswordRequestStatus ?? this.updatePasswordRequestStatus,
      updateUserDataRequestStatus:
          updateUserDataRequestStatus ?? this.updateUserDataRequestStatus,
      updatedUserDataInfoEntitie:
          updatedUserDataInfoEntitie ?? this.updatedUserDataInfoEntitie,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        updateUserPhotoRequestStatus,
        isPasswordHide,
        statusCode,
        newToken,
        followersData,
        followingData,
        pickedUserProfileImageFilePath,
        isEndOfFollowersData,
        isEndOfFollowingData,
        getMyFollowersRequestStatus,
        getMyFollowingRequestStatus,
        backGroundColors,
        backGroundColorGenerateRequestStatus,
        updatePasswordRequestStatus,
        errorMessage,
        updateUserDataRequestStatus,
        updatedUserDataInfoEntitie,
      ];
}
