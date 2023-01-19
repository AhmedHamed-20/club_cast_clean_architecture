import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_podcast_entitie.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/followers_following_data_entitie.dart';
import '../entities/other_users_data_entitie.dart';
import '../usecases/get_other_user_podcasts.dart';
import '../usecases/get_user_followers.dart';
import '../usecases/get_user_profile_data.dart';

abstract class BaseOtherUserProfilesRepository {
  Future<Either<Failure, OtherUserDataEntitie>> getOtherUsersProfiles(
      UserProfileDataGetParams params);
  Future<Either<Failure, OtherUserFollowersFollowingDataEntitie>>
      getUserFollowers(OtherUserFollowersFollowingParams params);
  Future<Either<Failure, OtherUserFollowersFollowingDataEntitie>>
      getUserFollowing(OtherUserFollowersFollowingParams params);
  Future<Either<Failure, OtherUserPodcastEntitie>> getOtherUserPodcast(
      OtherUserPodcastParams params);
}
