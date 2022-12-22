import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entitie.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/podcast_repository.dart';

class FollowingPodcastUsecase
    extends BaseUsecase<PodcastEntitie, MyFollowingPodcastParams> {
  final BasePodcastRepository basePodcastRepository;

  FollowingPodcastUsecase(this.basePodcastRepository);
  @override
  Future<Either<Failure, PodcastEntitie>> call(
      MyFollowingPodcastParams params) async {
    return await basePodcastRepository.getMyFollowingPodcast(params);
  }
}

class MyFollowingPodcastParams extends Equatable {
  final String accessToken;

  const MyFollowingPodcastParams(this.accessToken);
  @override
  List<Object?> get props => [accessToken];
}
