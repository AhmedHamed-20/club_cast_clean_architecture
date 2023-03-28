import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/followers_following_data_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_events_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/other_user_events.dart';

import '../../../../core/network/network_service.dart';
import '../../domain/usecases/follow_user.dart';
import '../../domain/usecases/get_other_user_podcasts.dart';
import '../../domain/usecases/get_user_followers.dart';
import '../../domain/usecases/get_user_profile_data.dart';
import '../models/other_user_podcast_model.dart';
import '../models/other_users_data_model.dart';

abstract class BaseRemoteOtherUsersDataSorce {
  Future<OtherUserDataModel> getOtherUsersProfiles(
      UserProfileDataGetParams params);

  Future<OtherUserFollowersFollowingDataModel> getUserFollowers(
      OtherUserFollowersFollowingParams params);
  Future<OtherUserFollowersFollowingDataModel> getUserFollowing(
      OtherUserFollowersFollowingParams params);

  Future<OtherUserPodcastModel> getOtherUserPodcasts(
      OtherUserPodcastParams params);
  Future<void> followUser(FollowUnfollowUserParams params);
  Future<void> unFollowUser(FollowUnfollowUserParams params);
  Future<OtherUserEventsModel> getOtherUserEvents(OtherUserEventsParams params);
}

class RemoteOtherUserDataSourceImpl extends BaseRemoteOtherUsersDataSorce {
  final NetworkService _networService;

  RemoteOtherUserDataSourceImpl(this._networService);
  @override
  Future<OtherUserDataModel> getOtherUsersProfiles(
      UserProfileDataGetParams params) async {
    try {
      final response = await _networService
          .getData(url: EndPoints.users + params.userId, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      });

      return OtherUserDataModel.fromJson(response.data['data']);
    } on Exception catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromException(e));
    }
  }

  @override
  Future<OtherUserFollowersFollowingDataModel> getUserFollowers(
      OtherUserFollowersFollowingParams params) async {
    try {
      final response = await _networService
          .getData(url: EndPoints.userFollowers(params.uid), query: {
        'page': params.page
      }, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      });

      return OtherUserFollowersFollowingDataModel.fromJson(response.data, true);
    } on Exception catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromException(e));
    }
  }

  @override
  Future<OtherUserFollowersFollowingDataModel> getUserFollowing(
      OtherUserFollowersFollowingParams params) async {
    try {
      final response = await _networService
          .getData(url: EndPoints.userFollowing(params.uid), query: {
        'page': params.page
      }, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      });

      return OtherUserFollowersFollowingDataModel.fromJson(
          response.data, false);
    } on Exception catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromException(e));
    }
  }

  @override
  Future<OtherUserPodcastModel> getOtherUserPodcasts(
      OtherUserPodcastParams params) async {
    try {
      final response = await _networService
          .getData(url: EndPoints.getuserPodCast + params.userId, query: {
        'page': params.page
      }, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      });

      return OtherUserPodcastModel.fromJson(
        response.data,
      );
    } on Exception catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromException(e));
    }
  }

  @override
  Future<void> followUser(FollowUnfollowUserParams params) async {
    try {
      await _networService
          .postData(url: EndPoints.userFollowing(params.userId), headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      });
    } on Exception catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromException(e));
    }
  }

  @override
  Future<void> unFollowUser(FollowUnfollowUserParams params) async {
    try {
      await _networService
          .deleteData(url: EndPoints.userFollowing(params.userId), headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      });
    } on Exception catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromException(e));
    }
  }

  @override
  Future<OtherUserEventsModel> getOtherUserEvents(
      OtherUserEventsParams params) async {
    try {
      final response = await _networService
          .getData(url: EndPoints.getMyFollowingEvent, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      }, query: {
        'createdBy': params.userId,
        'page': params.page
      });
      return OtherUserEventsModel.fromJson(response.data);
    } on Exception catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromException(e));
    }
  }
}
