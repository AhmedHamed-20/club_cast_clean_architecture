import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/services/service_locator.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/podcast_search_model.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/rooms__search_model.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/users_search_model.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/podcast_search.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/dio.dart';
import '../../../../core/network/endpoints.dart';

abstract class BaseRemoteSearchDataSoruce {
  Future<List<SearchUsersModel>> userSearch(SearchParams params);
  Future<List<SearchRoomsModel>> roomsSearch(SearchParams params);
  Future<PodcastSearchModel> podcastSearch(SearchParams params);
}

class RemoteSearchDataSource extends BaseRemoteSearchDataSoruce {
  @override
  Future<PodcastSearchModel> podcastSearch(SearchParams params) async {
    try {
      final response = await servicelocator<DioHelper>()
          .getData(url: EndPoints.searchPodCast + params.query, headers: {
        "Authorization": "Bearer ${params.accessToken}",
      });
      return PodcastSearchModel.fromJson(response?.data);
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<List<SearchRoomsModel>> roomsSearch(SearchParams params) async {
    try {
      final response = await servicelocator<DioHelper>()
          .getData(url: EndPoints.searchAboutRoom + params.query, headers: {
        "Authorization": "Bearer ${params.accessToken}",
      });
      return (response?.data['data'] as List)
          .map((e) => SearchRoomsModel.fromJson(e))
          .toList();
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<List<SearchUsersModel>> userSearch(SearchParams params) async {
    try {
      final response = await servicelocator<DioHelper>()
          .getData(url: EndPoints.searchUser + params.query, headers: {
        "Authorization": "Bearer ${params.accessToken}",
      });
      return (response?.data['data'] as List)
          .map((e) => SearchUsersModel.fromJson(e))
          .toList();
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }
}
