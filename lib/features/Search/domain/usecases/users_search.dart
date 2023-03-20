import 'package:club_cast_clean_architecture/features/Search/domain/entities/search_users_info_entity.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/podcast_search.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/base_search_repository.dart';

class UsersSearchUsecase
    extends BaseUsecase<List<SearchUsersEntity>, SearchParams> {
  final BaseSearchRepository baseSearchRepository;

  UsersSearchUsecase(this.baseSearchRepository);
  @override
  Future<Either<Failure, List<SearchUsersEntity>>> call(
      SearchParams params) async {
    return await baseSearchRepository.usersSearch(params);
  }
}
