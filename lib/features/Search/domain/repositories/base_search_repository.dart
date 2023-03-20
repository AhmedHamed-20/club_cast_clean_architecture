import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/podcast_search_entity.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/search_rooms_entity.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/search_users_info_entity.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/all_podcasts.dart';
import 'package:dartz/dartz.dart';

import '../usecases/podcast_search.dart';

abstract class BaseSearchRepository {
  Future<Either<Failure, PodcastSearchEntity>> podcastSearch(
      SearchParams params);
  Future<Either<Failure, PodcastSearchEntity>> getAllPodcasts(
      AllPodcastsParams params);
  Future<Either<Failure, List<SearchUsersEntity>>> usersSearch(
      SearchParams params);
  Future<Either<Failure, List<SearchRoomsEntity>>> roomsSearch(
      SearchParams params);
}
