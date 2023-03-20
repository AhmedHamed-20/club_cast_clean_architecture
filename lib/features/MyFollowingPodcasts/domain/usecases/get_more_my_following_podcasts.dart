import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entity.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/repositories/podcast_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class MoreMyFollowingPodcastsUsecase extends BaseUsecase<
    MyFollowingPodcastEntity, MoreMyFollowingPodcastParams> {
  final BasePodcastRepository basePodcastRepository;

  MoreMyFollowingPodcastsUsecase(this.basePodcastRepository);
  @override
  Future<Either<Failure, MyFollowingPodcastEntity>> call(
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
