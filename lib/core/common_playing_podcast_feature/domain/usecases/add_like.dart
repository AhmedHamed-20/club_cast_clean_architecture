import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/repository/base_commo_podcast_repository.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LikeAddMyPodcastsUsecast
    extends BaseUsecase<void, LikeAddMyPodcastsParams> {
  final BaseCommonPodcastRepository baseCommonPodcastRepository;

  LikeAddMyPodcastsUsecast(this.baseCommonPodcastRepository);
  @override
  Future<Either<Failure, void>> call(LikeAddMyPodcastsParams params) async {
    return await baseCommonPodcastRepository.addLikeToPodcast(params);
  }
}

class LikeAddMyPodcastsParams extends Equatable {
  final String accessToken;
  final String podcastId;
  const LikeAddMyPodcastsParams({
    required this.accessToken,
    required this.podcastId,
  });

  @override
  List<Object?> get props => [accessToken, podcastId];
}
