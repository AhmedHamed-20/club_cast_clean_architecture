import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/data/models/podcast_likes_users_info_model.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/usecases/get_podcast_likes_users.dart';
import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/core/network/network_service.dart';

import '../../domain/usecases/add_like.dart';
import '../../domain/usecases/download_podcast.dart';
import '../../domain/usecases/remove_like.dart';

abstract class BaseCommonPlayingPodcastDataSource {
  Future<List<PodcastLikesUsersInfoModel>> getPodcastLikesUsers(
      PodcastLikesUsersparams params);

  Future<void> downloadPodcast(PodcastDownloadParams params);

  Future<void> addLike(LikeAddMyPodcastsParams params);
  Future<void> removeLike(LikeRemoveMyPodcastsParams params);
}

class RemoteCommonPlayingPodcastDataSource
    extends BaseCommonPlayingPodcastDataSource {
  final NetworService _networService;

  RemoteCommonPlayingPodcastDataSource(this._networService);
  @override
  Future<List<PodcastLikesUsersInfoModel>> getPodcastLikesUsers(
      PodcastLikesUsersparams params) async {
    try {
      final response = await _networService.getData(
          url: EndPoints.getPodcastLikesUsers(params.podcastId),
          headers: {
            'Authorization': 'Bearer ${params.accessToken}',
          });
      return (response.data['data'] as List)
          .map((e) => PodcastLikesUsersInfoModel.fromJson(e))
          .toList();
    } on Exception catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromException(e));
    }
  }

  @override
  Future<void> downloadPodcast(PodcastDownloadParams params) async {
    try {
      await _networService.downloadData(
        url: params.podcastUrl,
        savedPath: params.savedPath,
        onReceive: (recieved, total) {
          var progress = recieved / total;
          params.receivedData.add(progress);
        },
      );
    } on Exception catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromException(e));
    }
  }

  @override
  Future<void> addLike(LikeAddMyPodcastsParams params) async {
    try {
      await _networService.postData(
        url: EndPoints.sendLike(params.podcastId),
        headers: {
          'Authorization': 'Bearer ${params.accessToken}',
        },
      );
    } on Exception catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromException(e));
    }
  }

  @override
  Future<void> removeLike(LikeRemoveMyPodcastsParams params) async {
    try {
      await _networService.deleteData(
        url: EndPoints.removeLikeFromPodcastById(params.podcastId),
        headers: {
          'Authorization': 'Bearer ${params.accessToken}',
        },
      );
    } on Exception catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromException(e));
    }
  }
}
