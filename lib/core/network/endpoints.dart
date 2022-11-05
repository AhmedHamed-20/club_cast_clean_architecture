class EndPoints {
  static String baseUrl =
      "https://audiocomms-podcast-platform.herokuapp.com/api";
  static String login = "$baseUrl/v1/users/login";
  static String signup = "$baseUrl/v1/users/signup";
  static String forgotPassword = "$baseUrl/v1/users/forgotPassword";
  static String allCategory = "$baseUrl/v1/categories/";
  static String profile = "$baseUrl/v1/users/me";
  static String updateProfile = "$baseUrl/v1/users/updateMe";
  static String updatePassword = "$baseUrl/v1/users/updateMyPassword";
  static String getAllPodcasts = '$baseUrl/v1/podcasts';
  static String sendLike = '$baseUrl/v1/podcasts/likes/';
  static String getPodcastLikesUsers = '$baseUrl/v1/podcasts/likes/';
  static String userById = 'v1/users/';
  static String getuserPodCast = '$baseUrl/v1/podcasts?createdBy=';
  static String searchUser = '$baseUrl/v1/users/search?s=';
  static String searchPodCast = '$baseUrl/v1/podcasts/search?s=';
  static String removePodCastById = '$baseUrl/v1/podcasts/';
  static String getMyPodCasts = '$baseUrl/v1/podcasts/me';
  static String getMyFollowingPodcasts = '$baseUrl/v1/podcasts/following/me';
  static String myFollowers = '$baseUrl/v1/users/me/followers';
  static String myFollowing = '$baseUrl/v1/users/me/following';

  static String generateSignature = '$baseUrl/v1/podcasts/generateSignature';
  static String createPodCast = '$baseUrl/v1/podcasts';

  static String createEvent = "$baseUrl/v1/events/me";
  static String getMyFollowingEvent = "$baseUrl/v1/events/?sort=date";
  static String getMyEvent = "$baseUrl/v1/events/me";
  static String deleteEvent = "$baseUrl/v1/events/";
  static String updateEventData = "$baseUrl/v1/events/";
  static String getAllPodCastWithoutMe = '$baseUrl/v1/podcasts/notMe';
  static String getAllRooms = '$baseUrl/v1/rooms';
  static String getRoom = '$baseUrl/v1/rooms/';
  static String searchAboutRoom = '$baseUrl/v1/rooms/search?s=';
  static String updateAvatar = "$baseUrl/v1/users/updateMyPhoto";
}
