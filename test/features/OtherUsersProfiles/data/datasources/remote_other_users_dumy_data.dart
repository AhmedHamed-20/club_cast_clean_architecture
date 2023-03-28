import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/followers_following_basic_data_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/followers_following_data_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_events_data_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_events_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_data_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_info_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_user_info.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_users_data_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/follow_user.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/get_other_user_podcasts.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/get_user_followers.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/get_user_profile_data.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/other_user_events.dart';

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
const OtherUserFollowersFollowingBasicDataModel
    tOtherUserFollowersFollowingBasicDataModel =
    OtherUserFollowersFollowingBasicDataModel(
        name: 'name', profileImage: 'profile', uid: 'uid');
const OtherUserFollowersFollowingDataModel
    tOtherUserFollowersFollowingDataModel =
    OtherUserFollowersFollowingDataModel(
        results: 1,
        otherUserFollowersFollowingUserDataEntitie: [
      tOtherUserFollowersFollowingBasicDataModel
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

const OtherUserFollowersFollowingParams tOtherUserFollowersFollowingParams =
    OtherUserFollowersFollowingParams(
        accessToken: 'accessToken', page: 1, uid: 'uid');
const OtherUserPodcastParams tOtherUserPodcastParams = OtherUserPodcastParams(
    accessToken: 'accessToken', page: 1, userId: 'userId');
const FollowUnfollowUserParams tFollowUnfollowUserParams =
    FollowUnfollowUserParams(accessToken: 'accessToken', userId: 'userId');
const OtherUserEventsParams tOtherUserEventsParams = OtherUserEventsParams(
    accessToken: 'accessToken', page: 1, userId: 'userId');
const UserProfileDataGetParams tOtherUserProfileDataSourceParams =
    UserProfileDataGetParams(accessToken: 'accessToken', userId: 'userId');
