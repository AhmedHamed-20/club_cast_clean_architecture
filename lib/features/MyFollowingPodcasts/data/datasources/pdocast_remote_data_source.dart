import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/dio.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/models/podcast_model.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/download_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_more_my_following_podcasts.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/remove_like_by_podcast_id.dart';
import 'package:dio/dio.dart';

abstract class BasePodcastRemoteDataSource {
  Future<PodcastModel> getMyFollowingPodcasts(MyFollowingPodcastParams params);
  Future<PodcastModel> getMoreMyFollowingPodcasts(
      MoreMyFollowingPodcastParams params);

  Future<void> addLikeToPodcasts(LikeAddParams params);
  Future<void> removeLikeFromPodcasts(LikeRemoveByPodcastIdParams params);

  Future<void> downloadPodcast(PodcastDownloadParams params);
}

class PodcastRemoteDataSourceImpl implements BasePodcastRemoteDataSource {
  @override
  Future<PodcastModel> getMyFollowingPodcasts(
      MyFollowingPodcastParams params) async {
    try {
      final response = await DioHelper.getData(
          url: EndPoints.getMyFollowingPodcasts,
          headers: {
            'Authorization': 'Bearer ${params.accessToken}',
          });
      return PodcastModel.fromJson(response?.data);
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

  @override
  Future<PodcastModel> getMoreMyFollowingPodcasts(
      MoreMyFollowingPodcastParams params) async {
    try {
      final response = await DioHelper.getData(
          url: EndPoints.getMyFollowingPodcasts,
          query: {
            'page': params.page
          },
          headers: {
            'Authorization': 'Bearer ${params.accessToken}',
          });

      return PodcastModel.fromJson(response?.data);
    } on DioError catch (error) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromJson(error.response?.data));
    }
  }

  @override
  Future<void> downloadPodcast(PodcastDownloadParams params) async {
    try {
      await DioHelper.downloadData(
        url: params.podcastUrl,
        savedPath: params.savedPath,
        onReceive: (recieved, total) {
          var progress = recieved / total;
          params.receivedData.add(progress);
        },
      );
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromJson(e.response?.data));
    }
  }
}
