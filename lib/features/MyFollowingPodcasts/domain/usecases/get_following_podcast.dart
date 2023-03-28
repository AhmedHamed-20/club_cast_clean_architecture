import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/podcast_repository.dart';

class MyFollowingPodcastGetUsecase
    extends BaseUsecase<MyFollowingPodcastEntity, MyFollowingPodcastParams> {
  final BaseMyFollowingPodcastRepository basePodcastRepository;

  MyFollowingPodcastGetUsecase(this.basePodcastRepository);
  @override
  Future<Either<Failure, MyFollowingPodcastEntity>> call(
      MyFollowingPodcastParams params) async {
    return await basePodcastRepository.getMyFollowingPodcast(params);
  }
}

class MyFollowingPodcastParams extends Equatable {
  final String accessToken;
  final int page;
  const MyFollowingPodcastParams(this.accessToken, this.page);
  @override
  List<Object?> get props => [accessToken, page];
}
