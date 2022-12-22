import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/repositories/podcast_repository.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class MoreMyFollowingPodcastsUsecase
    extends BaseUsecase<PodcastEntitie, MoreMyFollowingPodcastParams> {
  final BasePodcastRepository basePodcastRepository;

  MoreMyFollowingPodcastsUsecase(this.basePodcastRepository);
  @override
  Future<Either<Failure, PodcastEntitie>> call(
      MoreMyFollowingPodcastParams params) async {
    return await basePodcastRepository.getMoreMyFollowingPodcast(params);
  }
}

class MoreMyFollowingPodcastParams extends Equatable {
  final String accessToken;
  final String page;

  const MoreMyFollowingPodcastParams(
      {required this.accessToken, required this.page});

  @override
  List<Object?> get props => [accessToken, page];
}
