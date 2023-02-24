import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/podcast_search_entitie.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/base_search_repository.dart';

class AllPodcastsUsecase
    extends BaseUsecase<PodcastSearchEntitie, AllPodcastsParams> {
  final BaseSearchRepository baseSearchRepository;

  AllPodcastsUsecase(this.baseSearchRepository);
  @override
  Future<Either<Failure, PodcastSearchEntitie>> call(
      AllPodcastsParams params) async {
    return await baseSearchRepository.getAllPodcasts(params);
  }
}

class AllPodcastsParams extends Equatable {
  final String accessToken;
  final int page;
  const AllPodcastsParams({required this.accessToken, required this.page});

  @override
  List<Object?> get props => [accessToken, page];
}
