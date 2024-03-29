import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entity.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:dartz/dartz.dart';

import '../usecases/remove_like_by_podcast_id.dart';

abstract class BaseMyFollowingPodcastRepository {
  Future<Either<Failure, MyFollowingPodcastEntity>> getMyFollowingPodcast(
      MyFollowingPodcastParams params);

  Future<Either<Failure, void>> addLikeToPodcast(LikeAddParams params);

  Future<Either<Failure, void>> removeLikeFromPodcast(
      LikeRemoveByPodcastIdParams params);
}
