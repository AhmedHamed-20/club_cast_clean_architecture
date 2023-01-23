import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/podcast_likes_users_info_model.dart';
import '../usecases/add_like.dart';
import '../usecases/download_podcast.dart';
import '../usecases/get_podcast_likes_users.dart';
import '../usecases/remove_like.dart';

abstract class BaseCommonPodcastRepository {
  Future<Either<Failure, List<PodcastLikesUsersInfoModel>>>
      getPodcastLikesUsers(PodcastLikesUsersparams params);
  Future<Either<Failure, void>> downloadPodcast(PodcastDownloadParams params);
  Future<Either<Failure, void>> addLikeToPodcast(
      LikeAddMyPodcastsParams params);

  Future<Either<Failure, void>> removeLike(LikeRemoveMyPodcastsParams params);
}
