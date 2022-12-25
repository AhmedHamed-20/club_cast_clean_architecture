enum LoginRequestStatus {
  idle,
  loading,
  loginSuccess,
  cachedSuccess,
  error,
}

enum PodcastInfoScreenColorsGenerateRequestStatus {
  loading,
  generated,
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

enum MyFollowingPodcastsUsersLikesRequestStatus {
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
