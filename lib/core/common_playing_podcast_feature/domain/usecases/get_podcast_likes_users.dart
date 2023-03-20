import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/entities/podcast_likes_users_entity.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/repository/base_commo_podcast_repository.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../usecase/usecase.dart';

class PodcastLikesUsersUsecase extends BaseUsecase<
    List<PodcastLikesUsersInfoEntity>, PodcastLikesUsersparams> {
  final BaseCommonPodcastRepository baseCommonPodcastRepository;
  PodcastLikesUsersUsecase(this.baseCommonPodcastRepository);
  @override
  Future<Either<Failure, List<PodcastLikesUsersInfoEntity>>> call(
      PodcastLikesUsersparams params) async {
    return await baseCommonPodcastRepository.getPodcastLikesUsers(params);
  }
}

class PodcastLikesUsersparams extends Equatable {
  final String accessToken;
  final String podcastId;

  const PodcastLikesUsersparams(this.accessToken, this.podcastId);

  @override
  List<Object?> get props => [accessToken, podcastId];
}
