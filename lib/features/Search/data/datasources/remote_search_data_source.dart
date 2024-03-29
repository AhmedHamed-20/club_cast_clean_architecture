import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/podcast_search_model.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/rooms__search_model.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/users_search_model.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/all_podcasts.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/podcast_search.dart';

import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';

abstract class BaseRemoteSearchDataSoruce {
  Future<List<SearchUsersModel>> userSearch(SearchParams params);
  Future<List<SearchRoomsModel>> roomsSearch(SearchParams params);
  Future<PodcastSearchModel> podcastSearch(SearchParams params);
  Future<PodcastSearchModel> getAllPodcasts(AllPodcastsParams params);
}

class RemoteSearchDataSource extends BaseRemoteSearchDataSoruce {
  final NetworkService _networService;

  RemoteSearchDataSource(this._networService);
  @override
  Future<PodcastSearchModel> podcastSearch(SearchParams params) async {
    try {
      final response = await _networService
          .getData(url: EndPoints.searchPodCast + params.query, headers: {
        "Authorization": "Bearer ${params.accessToken}",
      });
      return PodcastSearchModel.fromJson(response.data);
    } on Exception catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromException(e));
    }
  }

  @override
  Future<List<SearchRoomsModel>> roomsSearch(SearchParams params) async {
    try {
      final response = await _networService
          .getData(url: EndPoints.searchAboutRoom + params.query, headers: {
        "Authorization": "Bearer ${params.accessToken}",
      });
      return (response.data['data'] as List)
          .map((e) => SearchRoomsModel.fromJson(e))
          .toList();
    } on Exception catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromException(e));
    }
  }

  @override
  Future<List<SearchUsersModel>> userSearch(SearchParams params) async {
    try {
      final response = await _networService
          .getData(url: EndPoints.searchUser + params.query, headers: {
        "Authorization": "Bearer ${params.accessToken}",
      });
      return (response.data['data'] as List)
          .map((e) => SearchUsersModel.fromJson(e))
          .toList();
    } on Exception catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromException(e));
    }
  }

  @override
  Future<PodcastSearchModel> getAllPodcasts(AllPodcastsParams params) async {
    try {
      final response = await _networService
          .getData(url: EndPoints.getAllPodCastWithoutMe, headers: {
        "Authorization": "Bearer ${params.accessToken}",
      }, query: {
        "page": params.page,
      });
      return PodcastSearchModel.fromJson(response.data);
    } on Exception catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromException(e));
    }
  }
}
