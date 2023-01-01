class EndPoints {
  static const String baseUrl =
      "https://audiocomms-podcast-api.onrender.com/api";
  static const String getMe = '$baseUrl/v1/users/me';
  static const String login = "$baseUrl/v1/users/login";
  static const String signup = "$baseUrl/v1/users/signup";
  static const String forgotPassword = "$baseUrl/v1/users/forgotPassword";
  static const String allCategory = "$baseUrl/v1/categories/";
  static const String profile = "$baseUrl/v1/users/me";
  static const String updateProfile = "$baseUrl/v1/users/updateMe";
  static const String updatePassword = "$baseUrl/v1/users/updateMyPassword";
  static const String getAllPodcasts = '$baseUrl/v1/podcasts';
  static String sendLike(String podcastId) =>
      '$baseUrl/v1/podcasts/likes/$podcastId';
  static String getPodcastLikesUsers(String podcastId) =>
      '$baseUrl/v1/podcasts/likes/$podcastId';
  static const String userById = 'v1/users/';
  static const String getuserPodCast = '$baseUrl/v1/podcasts?createdBy=';
  static const String searchUser = '$baseUrl/v1/users/search?s=';
  static const String searchPodCast = '$baseUrl/v1/podcasts/search?s=';
  static const String removePodCastById = '$baseUrl/v1/podcasts/';
  static const String getMyPodCasts = '$baseUrl/v1/podcasts/me';
  static const String getMyFollowingPodcasts =
      '$baseUrl/v1/podcasts/following/me';
  static const String myFollowers = '$baseUrl/v1/users/me/followers';
  static const String myFollowing = '$baseUrl/v1/users/me/following';

  static const String generateSignature =
      '$baseUrl/v1/podcasts/generateSignature';
  static const String createPodCast = '$baseUrl/v1/podcasts';

  static const String createEvent = "$baseUrl/v1/events/me";
  static const String getMyFollowingEvent = "$baseUrl/v1/events/?sort=date";
  static const String getMyEvent = "$baseUrl/v1/events/me";
  static const String deleteEvent = "$baseUrl/v1/events/";
  static const String updateEventData = "$baseUrl/v1/events/";
  static const String getAllPodCastWithoutMe = '$baseUrl/v1/podcasts/notMe';
  static const String getAllRooms = '$baseUrl/v1/rooms';
  static const String getRoom = '$baseUrl/v1/rooms/';
  static const String searchAboutRoom = '$baseUrl/v1/rooms/search?s=';
  static const String updateAvatar = "$baseUrl/v1/users/updateMyPhoto";
  static String removeLikeFromPodcastById(String podcastId) =>
      '$baseUrl/v1/podcasts/likes/$podcastId';

  static String uploadPodcast({
    required int timestamp,
    required String apiKey,
    required String cloudName,
    required String signature,
  }) =>
      'https://api.cloudinary.com/v1_1/$cloudName/video/upload?api_key=$apiKey&timestamp=$timestamp&signature=$signature';
}
