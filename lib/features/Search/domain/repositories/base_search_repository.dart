import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/podcast_search_entitie.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/search_rooms_entitie.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/search_users_info_entite.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/all_podcasts.dart';
import 'package:dartz/dartz.dart';

import '../usecases/podcast_search.dart';

abstract class BaseSearchRepository {
  Future<Either<Failure, PodcastSearchEntitie>> podcastSearch(
      SearchParams params);
  Future<Either<Failure, PodcastSearchEntitie>> getAllPodcasts(
      AllPodcastsParams params);
  Future<Either<Failure, List<SearchUsersEntite>>> usersSearch(
      SearchParams params);
  Future<Either<Failure, List<SearchRoomsEntitie>>> roomsSearch(
      SearchParams params);
}
