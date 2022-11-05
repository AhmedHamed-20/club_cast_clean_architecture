import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/entities/podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/entities/podcast_likes_users_entitie.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/get_podcast_likes_users.dart';
import 'package:dartz/dartz.dart';

import '../usecases/remove_like_by_podcast_id.dart';

abstract class BasePodcastRepository {
  Future<Either<Failure, List<PodcastEntitie>>> getMyFollowingPodcast(
      MyFollowingPodcastParams params);
  Future<Either<Failure, void>> addLikeToPodcast(LikeAddParams params);
  Future<Either<Failure, List<PodcastLikesUsersInfoEntitie>>>
      getPodcastLikesUsers(PodcastLikesUsersparams params);
  Future<Either<Failure, void>> removeLikeFromPodcast(
      LikeRemoveByPodcastIdParams params);
}
