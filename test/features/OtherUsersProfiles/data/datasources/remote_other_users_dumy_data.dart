import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/followers_following_basic_data_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/followers_following_data_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_events_data_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_events_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_data_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_info_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_user_info.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_users_data_model.dart';

const OtherUserDataModel tOtherUsersDataModel = OtherUserDataModel(
    userName: 'userName',
    userPhoto: 'userPhoto',
    followers: 1,
    following: 1,
    id: 'id',
    email: 'email',
    isFollowing: true,
    createdAt: ' createdAt',
    bio: 'bio');
const OtherUserFollowersFollowingDataModel
    tOtherUserFollowersFollowingDataModel =
    OtherUserFollowersFollowingDataModel(
        results: 1,
        otherUserFollowersFollowingUserDataEntitie: [
      OtherUserFollowersFollowingBasicDataModel(
          name: 'name', profileImage: 'profile', uid: 'uid')
    ]);
const OtherUserPodcastDataModel tOtherUserPodcastDataModel =
    OtherUserPodcastDataModel(
        podcastId: 'podcastId',
        podcastName: 'podcastName',
        podcastLikesCount: 1,
        category: 'category',
        createdAt: 'createdAt',
        isLiked: true,
        podcastUserInfo: tOtherUserPodcastInfoModel,
        podcastInfo: tOtherUserPodcastAudioInfoModel);
const OtherUserPodcastUserInfoModel tOtherUserPodcastInfoModel =
    OtherUserPodcastUserInfoModel('userName', 'userImage', 'userId');
const OtherUserPodcastAudioInfoModel tOtherUserPodcastAudioInfoModel =
    OtherUserPodcastAudioInfoModel(1, 'podcastUrl');
const OtherUserPodcastModel tOtherUserPodcastModel = OtherUserPodcastModel(
    results: 1, otherUserPodcastDataEntitie: [tOtherUserPodcastDataModel]);
const OtherUserEventsDataModel tOtherUserEventsDataModel =
    OtherUserEventsDataModel(
        eventName: 'eventName',
        eventDescription: 'eventDescription',
        eventDate: 'eventDate',
        eventId: 'eventId');
const OtherUserEventsModel tOtherUserEventsModel =
    OtherUserEventsModel(results: 1, events: [tOtherUserEventsDataModel]);
