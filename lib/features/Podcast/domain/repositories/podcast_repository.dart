import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/entities/podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/get_following_podcast.dart';
import 'package:dartz/dartz.dart';

abstract class BasePodcastRepository {
  Future<Either<Failure, List<PodcastEntitie>>> getMyFollowingPodcast(
      MyFollowingPOdcastParams params);
}
