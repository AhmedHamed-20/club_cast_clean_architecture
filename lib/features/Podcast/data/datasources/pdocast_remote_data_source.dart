import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/dio.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/features/Podcast/data/models/podcast_model.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/get_following_podcast.dart';
import 'package:dio/dio.dart';

abstract class BasePodcastRemoteDataSource {
  Future<List<PodcastModel>> getMyFollowingPodcasts(
      MyFollowingPOdcastParams params);
}

class PodcastRemoteDataSourceImpl implements BasePodcastRemoteDataSource {
  @override
  Future<List<PodcastModel>> getMyFollowingPodcasts(
      MyFollowingPOdcastParams params) async {
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
}
