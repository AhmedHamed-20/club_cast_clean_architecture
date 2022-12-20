import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/my_following_events_entitie.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/user_data_entitie.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_cached_access_token.dart';
import 'package:dartz/dartz.dart';

import '../usecases/get_active_user_data.dart';
import '../usecases/get_my_following_events.dart';

abstract class BaseLayoutRepository {
  Future<Either<Failure, UserDataEntitie>> getActiveUserData(
      ActiveUserDataGetParams params);
  Future<Either<Failure, String>> getAccessTokenFromCache(
      CachedAccessTokenGetParams params);

  Future<Either<Failure, List<MyFollowingEventsEntitie>>> getMyFollowingEvents(
      MyFollowingEventsParams params);
}
