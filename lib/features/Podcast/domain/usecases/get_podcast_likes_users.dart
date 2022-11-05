import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/entities/podcast_likes_users_entitie.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/podcast_repository.dart';

class PodcastLikesUsersUsecase extends BaseUsecase<
    List<PodcastLikesUsersInfoEntitie>, PodcastLikesUsersparams> {
  final BasePodcastRepository basePodcastRepository;

  PodcastLikesUsersUsecase(this.basePodcastRepository);
  @override
  Future<Either<Failure, List<PodcastLikesUsersInfoEntitie>>> call(
      PodcastLikesUsersparams params) async {
    return await basePodcastRepository.getPodcastLikesUsers(params);
  }
}

class PodcastLikesUsersparams extends Equatable {
  final String accessToken;
  final String podcastId;

  const PodcastLikesUsersparams(this.accessToken, this.podcastId);

  @override
  List<Object?> get props => [accessToken, podcastId];
}
