import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/dio.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/followers_following_data_model.dart';
import 'package:dio/dio.dart';

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
}

class RemoteOtherUserDataSourceImpl extends BaseRemoteOtherUsersDataSorce {
  @override
  Future<OtherUserDataModel> getOtherUsersProfiles(
      UserProfileDataGetParams params) async {
    try {
      final response = await DioHelper.getData(
          url: EndPoints.userById + params.userId,
          headers: {
            'Authorization': 'Bearer ${params.accessToken}',
          });

      return OtherUserDataModel.fromJson(response?.data['data']);
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<OtherUserFollowersFollowingDataModel> getUserFollowers(
      OtherUserFollowersFollowingParams params) async {
    try {
      final response = await DioHelper.getData(
          url: EndPoints.userFollowers(params.uid),
          query: {
            'page': params.page
          },
          headers: {
            'Authorization': 'Bearer ${params.accessToken}',
          });

      return OtherUserFollowersFollowingDataModel.fromJson(
          response?.data, true);
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<OtherUserFollowersFollowingDataModel> getUserFollowing(
      OtherUserFollowersFollowingParams params) async {
    try {
      final response = await DioHelper.getData(
          url: EndPoints.userFollowing(params.uid),
          query: {
            'page': params.page
          },
          headers: {
            'Authorization': 'Bearer ${params.accessToken}',
          });

      return OtherUserFollowersFollowingDataModel.fromJson(
          response?.data, false);
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<OtherUserPodcastModel> getOtherUserPodcasts(
      OtherUserPodcastParams params) async {
    try {
      final response = await DioHelper.getData(
          url: EndPoints.getuserPodCast + params.userId,
          query: {
            'page': params.page
          },
          headers: {
            'Authorization': 'Bearer ${params.accessToken}',
          });

      return OtherUserPodcastModel.fromJson(
        response?.data,
      );
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }
}
