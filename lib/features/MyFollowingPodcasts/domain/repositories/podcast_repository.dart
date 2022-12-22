import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_likes_users_entitie.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_more_my_following_podcasts.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_podcast_likes_users.dart';
import 'package:dartz/dartz.dart';

import '../usecases/remove_like_by_podcast_id.dart';

abstract class BasePodcastRepository {
  Future<Either<Failure, PodcastEntitie>> getMyFollowingPodcast(
      MyFollowingPodcastParams params);
  Future<Either<Failure, PodcastEntitie>> getMoreMyFollowingPodcast(
      MoreMyFollowingPodcastParams params);
  Future<Either<Failure, void>> addLikeToPodcast(LikeAddParams params);
  Future<Either<Failure, List<PodcastLikesUsersInfoEntitie>>>
      getPodcastLikesUsers(PodcastLikesUsersparams params);
  Future<Either<Failure, void>> removeLikeFromPodcast(
      LikeRemoveByPodcastIdParams params);
}
