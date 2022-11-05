import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/entities/podcast_entitie.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/podcast_repository.dart';

class FollowingPodcastUsecase
    extends BaseUsecase<List<PodcastEntitie>, MyFollowingPOdcastParams> {
  final BasePodcastRepository basePodcastRepository;

  FollowingPodcastUsecase(this.basePodcastRepository);
  @override
  Future<Either<Failure, List<PodcastEntitie>>> call(
      MyFollowingPOdcastParams params) async {
    return await basePodcastRepository.getMyFollowingPodcast(params);
  }
}

class MyFollowingPOdcastParams extends Equatable {
  final String accessToken;

  const MyFollowingPOdcastParams(this.accessToken);
  @override
  List<Object?> get props => [accessToken];
}
