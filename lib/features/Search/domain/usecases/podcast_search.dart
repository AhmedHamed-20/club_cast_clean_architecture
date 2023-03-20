import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/entities/podcast_search_entity.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/repositories/base_search_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';

class PodcastSearchUsecase
    extends BaseUsecase<PodcastSearchEntity, SearchParams> {
  final BaseSearchRepository baseSearchRepository;

  PodcastSearchUsecase(this.baseSearchRepository);
  @override
  Future<Either<Failure, PodcastSearchEntity>> call(SearchParams params) async {
    return await baseSearchRepository.podcastSearch(params);
  }
}

class SearchParams extends Equatable {
  final String query;
  final String accessToken;

  const SearchParams({required this.query, required this.accessToken});

  @override
  List<Object?> get props => [query, accessToken];
}
