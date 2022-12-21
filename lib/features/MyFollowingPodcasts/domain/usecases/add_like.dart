import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/podcast_repository.dart';

class LikeAddByIdUsecase extends BaseUsecase<void, LikeAddParams> {
  final BasePodcastRepository podcastRepository;

  LikeAddByIdUsecase(this.podcastRepository);
  @override
  Future<Either<Failure, void>> call(LikeAddParams params) async {
    return await podcastRepository.addLikeToPodcast(params);
  }
}

class LikeAddParams extends Equatable {
  final String accessToken;
  final String podcastId;

  const LikeAddParams(this.accessToken, this.podcastId);

  @override
  List<Object?> get props => [accessToken, podcastId];
}
