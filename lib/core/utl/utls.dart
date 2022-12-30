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

enum PodcastDownloadRequestStatus {
  idle,
  loading,
  downloaded,
  error,
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

enum MyPodCastRemoveRequestStatus {
  idle,
  loading,
  removed,
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
