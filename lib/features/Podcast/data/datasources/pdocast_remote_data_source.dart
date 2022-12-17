import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/dio.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/features/Podcast/data/models/podcast_likes_users_info_model.dart';
import 'package:club_cast_clean_architecture/features/Podcast/data/models/podcast_model.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/get_podcast_likes_users.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/remove_like_by_podcast_id.dart';
import 'package:dio/dio.dart';

abstract class BasePodcastRemoteDataSource {
  Future<List<PodcastModel>> getMyFollowingPodcasts(
      MyFollowingPodcastParams params);
  Future<void> addLikeToPodcasts(LikeAddParams params);
  Future<void> removeLikeFromPodcasts(LikeRemoveByPodcastIdParams params);
  Future<List<PodcastLikesUsersInfoModel>> getPodcastLikesUsers(
      PodcastLikesUsersparams params);
}

class PodcastRemoteDataSourceImpl implements BasePodcastRemoteDataSource {
  @override
  Future<List<PodcastModel>> getMyFollowingPodcasts(
      MyFollowingPodcastParams params) async {
    try {
      final response = await DioHelper.getData(
          url: EndPoints.getMyFollowingPodcasts,
          headers: {
            'Authorization': 'Bearer ${params.accessToken}',
          });
      return List.from((response?.data['data'] as List)
          .map((e) => PodcastModel.fromJson(e)));
    } on DioError catch (error) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromJson(error.response?.data));
    }
  }

  @override
  Future<void> addLikeToPodcasts(LikeAddParams params) async {
    try {
      await DioHelper.postData(
          url: EndPoints.sendLike(params.podcastId),
          headers: {
            'Authorization': 'Bearer ${params.accessToken}',
          },
          data: {
            'podcastId': params.podcastId
          });
    } on DioError catch (error) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromJson(error.response?.data));
    }
  }

  @override
  Future<List<PodcastLikesUsersInfoModel>> getPodcastLikesUsers(
      PodcastLikesUsersparams params) async {
    try {
      final respone = await DioHelper.getData(
        url: EndPoints.getPodcastLikesUsers(params.podcastId),
        headers: {
          'Authorization': 'Bearer ${params.accessToken}',
        },
      );
      return List.from((respone?.data['data'] as List)
          .map((e) => PodcastLikesUsersInfoModel.fromJson(e)));
    } on DioError catch (error) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromJson(error.response?.data));
    }
  }

  @override
  Future<void> removeLikeFromPodcasts(
      LikeRemoveByPodcastIdParams params) async {
    try {
      await DioHelper.deleteData(
        url: EndPoints.removeLikeFromPodcastById(params.podcastId),
        headers: {
          'Authorization': 'Bearer ${params.accessToken}',
        },
      );
    } on DioError catch (error) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromJson(error.response?.data));
    }
  }
}