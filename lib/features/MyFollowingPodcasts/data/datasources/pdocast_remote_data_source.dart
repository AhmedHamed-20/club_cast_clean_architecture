import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/models/my_following_podcast_model.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/remove_like_by_podcast_id.dart';

import '../../../../core/network/network_service.dart';

abstract class BaseMyFollowingPodcastRemoteDataSource {
  Future<MyFollowingPodcastModel> getMyFollowingPodcasts(
      MyFollowingPodcastParams params);

  Future<void> addLikeToPodcasts(LikeAddParams params);
  Future<void> removeLikeFromPodcasts(LikeRemoveByPodcastIdParams params);
}

class MyFollowingPodcastRemoteDataSourceImpl
    implements BaseMyFollowingPodcastRemoteDataSource {
  final NetworService _networService;

  MyFollowingPodcastRemoteDataSourceImpl(this._networService);
  @override
  Future<MyFollowingPodcastModel> getMyFollowingPodcasts(
      MyFollowingPodcastParams params) async {
    try {
      final response = await _networService
          .getData(url: EndPoints.getMyFollowingPodcasts, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      }, query: {
        'page': params.page,
      });
      return MyFollowingPodcastModel.fromJson(response.data);
    } on Exception catch (error) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromException(error));
    }
  }

  @override
  Future<void> addLikeToPodcasts(LikeAddParams params) async {
    try {
      await _networService
          .postData(url: EndPoints.sendLike(params.podcastId), headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      }, data: {
        'podcastId': params.podcastId
      });
    } on Exception catch (error) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromException(error));
    }
  }

  @override
  Future<void> removeLikeFromPodcasts(
      LikeRemoveByPodcastIdParams params) async {
    try {
      await _networService.deleteData(
        url: EndPoints.removeLikeFromPodcastById(params.podcastId),
        headers: {
          'Authorization': 'Bearer ${params.accessToken}',
        },
      );
    } on Exception catch (error) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromException(error));
    }
  }
}
