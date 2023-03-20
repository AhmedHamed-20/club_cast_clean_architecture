import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_event.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_podcast_entity.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/follow_user.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/followers_following_data_entity.dart';
import '../entities/other_users_data_entity.dart';
import '../usecases/get_other_user_podcasts.dart';
import '../usecases/get_user_followers.dart';
import '../usecases/get_user_profile_data.dart';
import '../usecases/other_user_events.dart';

abstract class BaseOtherUserProfilesRepository {
  Future<Either<Failure, OtherUserDataEntity>> getOtherUsersProfiles(
      UserProfileDataGetParams params);
  Future<Either<Failure, OtherUserFollowersFollowingDataEntity>>
      getUserFollowers(OtherUserFollowersFollowingParams params);
  Future<Either<Failure, OtherUserFollowersFollowingDataEntity>>
      getUserFollowing(OtherUserFollowersFollowingParams params);
  Future<Either<Failure, OtherUserPodcastEntity>> getOtherUserPodcast(
      OtherUserPodcastParams params);

  Future<Either<Failure, void>> followUser(FollowUnfollowUserParams params);
  Future<Either<Failure, void>> unFollowUser(FollowUnfollowUserParams params);
  Future<Either<Failure, OtherUserEventsEntity>> getOtherUserEvents(
      OtherUserEventsParams params);
}
