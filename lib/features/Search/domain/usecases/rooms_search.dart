import 'package:club_cast_clean_architecture/features/Search/domain/entities/search_rooms_entity.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/podcast_search.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/base_search_repository.dart';

class RoomsSearchUsecase
    extends BaseUsecase<List<SearchRoomsEntity>, SearchParams> {
  final BaseSearchRepository baseSearchRepository;

  RoomsSearchUsecase(this.baseSearchRepository);
  @override
  Future<Either<Failure, List<SearchRoomsEntity>>> call(
      SearchParams params) async {
    return await baseSearchRepository.roomsSearch(params);
  }
}
