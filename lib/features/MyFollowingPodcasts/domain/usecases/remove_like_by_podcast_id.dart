import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/repositories/podcast_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class MyFollowingPodcastLikeRemoveByPodcastIdUsecase
    extends BaseUsecase<void, LikeRemoveByPodcastIdParams> {
  final BaseMyFollowingPodcastRepository basePodcastRepository;

  MyFollowingPodcastLikeRemoveByPodcastIdUsecase(this.basePodcastRepository);
  @override
  Future<Either<Failure, void>> call(LikeRemoveByPodcastIdParams params) async {
    return await basePodcastRepository.removeLikeFromPodcast(params);
  }
}

class LikeRemoveByPodcastIdParams extends Equatable {
  final String accessToken;
  final String podcastId;

  const LikeRemoveByPodcastIdParams(
      {required this.accessToken, required this.podcastId});

  @override
  List<Object?> get props => [accessToken, podcastId];
}
