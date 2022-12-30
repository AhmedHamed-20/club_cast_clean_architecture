import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/data/models/podcast_likes_users_info_model.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/usecases/get_podcast_likes_users.dart';
import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/dio.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:dio/dio.dart';

import '../../domain/usecases/download_podcast.dart';

abstract class BaseCommonPlayingPodcastDataSource {
  Future<List<PodcastLikesUsersInfoModel>> getPodcastLikesUsers(
      PodcastLikesUsersparams params);

  Future<void> downloadPodcast(PodcastDownloadParams params);
}

class RemoteCommonPlayingPodcastDataSource
    extends BaseCommonPlayingPodcastDataSource {
  @override
  Future<List<PodcastLikesUsersInfoModel>> getPodcastLikesUsers(
      PodcastLikesUsersparams params) async {
    try {
      final response = await DioHelper.getData(
          url: EndPoints.getPodcastLikesUsers(params.podcastId),
          headers: {
            'Authorization': 'Bearer ${params.accessToken}',
          });
      return (response?.data['data'] as List)
          .map((e) => PodcastLikesUsersInfoModel.fromJson(e))
          .toList();
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromJson(e.response?.data));
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
