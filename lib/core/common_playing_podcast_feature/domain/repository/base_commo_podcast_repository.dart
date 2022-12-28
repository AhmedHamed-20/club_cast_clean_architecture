import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/podcast_likes_users_info_model.dart';
import '../usecases/get_podcast_likes_users.dart';

abstract class BaseCommonPodcastRepository {
  Future<Either<Failure, List<PodcastLikesUsersInfoModel>>>
      getPodcastLikesUsers(PodcastLikesUsersparams params);
}
