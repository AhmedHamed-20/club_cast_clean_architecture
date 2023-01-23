// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/repository/base_commo_podcast_repository.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LikeRemoveMyPodcastsUsecast
    extends BaseUsecase<void, LikeRemoveMyPodcastsParams> {
  final BaseCommonPodcastRepository baseCommonPodcastRepository;

  LikeRemoveMyPodcastsUsecast(this.baseCommonPodcastRepository);
  @override
  Future<Either<Failure, void>> call(LikeRemoveMyPodcastsParams params) async {
    return await baseCommonPodcastRepository.removeLike(params);
  }
}

class LikeRemoveMyPodcastsParams extends Equatable {
  final String accessToken;
  final String podcastId;
  const LikeRemoveMyPodcastsParams({
    required this.accessToken,
    required this.podcastId,
  });

  @override
  List<Object?> get props => [accessToken, podcastId];
}
