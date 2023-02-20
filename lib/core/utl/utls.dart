enum LoginRequestStatus {
  idle,
  loading,
  loginSuccess,
  cachedSuccess,
  error,
}

enum BackGroundColorGenerateRequestStatus {
  loading,
  generated,
  error,
}

enum LogoutRequestStatus {
  idle,
  loading,
  logoutSuccess,
  error,
}

enum AccessTokenUpdateRequestStatus {
  idle,
  loading,
  success,
  error,
}

enum PodcastDownloadRequestStatus {
  idle,
  loading,
  downloaded,
  error,
}

enum LayoutBottomSheetStatus {
  idle,
  playingPodcast,
  playingLiveVoiceRoom,
}

enum PlayPodcastRequestStatus {
  idle,
  loading,
  playing,
  paused,
  stoped,
  error,
}

enum SignUpRequestStatus {
  idle,
  loading,
  signUpSuccess,
  cachedSuccess,
  error,
}

enum ForgetPasswordRequestStatus {
  idle,
  loading,
  success,
  error,
}

enum MyFollowingPodcastsRequestStatus {
  loading,
  success,
  error,
}

enum PodcastsUsersLikesRequestStatus {
  loading,
  success,
  error,
}

enum UserDataGetRequestStatus {
  loading,
  success,
  error,
}

enum MyPodCastRequestStatus {
  loading,
  success,
  error,
}

enum MyDataRemoveRequestStatus {
  idle,
  loading,
  removed,
  error,
}

enum MyDataUpdateRequestStatus {
  idle,
  loading,
  updated,
  error,
}

enum UpdateUserDataRequestStatus {
  idle,
  loading,
  success,
  error,
}

enum EventCreateRequestStatus {
  idle,
  loading,
  success,
  error,
}

enum UploadPodcastRequestStatus {
  idle,
  loading,
  signatureGetSuccess,
  podcastUploadedSuccess,
  podcastCreatedSucess,
  error,
}

enum FollowersFollowingDataGetRequestStatus {
  loading,
  success,
  error,
}

enum FollowUnfollowUserRequestStatus {
  idle,
  loading,
  success,
  error,
}

enum AllRoomsGetRequestStatus {
  loading,
  success,
  error,
}

enum PrivateRoomsGetRequestStatus {
  idle,
  loading,
  success,
  error,
}

enum ConnectToSocketRequestStatus {
  idle,
  loading,
  success,
  error,
}

enum JoinRoomRequestStatus {
  idle,
  loading,
  success,
  left,
  error,
}

enum CreateRoomRequestStatus {
  idle,
  loading,
  success,
  left,

  error,
}

enum RoomMessagesGetRequestStatus {
  idle,
  loading,
  success,
  error,
}

enum LiveVoiceRoomFloatingButtonStatus {
  askToTalk,
  mute,
  unmute,
}
