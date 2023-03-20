import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../entities/other_users_basic_info_entity.dart';
import '../../repositories/base_user_info_repository.dart';
import 'get_followers.dart';

class MyFollowingGetUseCase
    extends BaseUsecase<OtherUsersDataEntity, FollowersFollowingParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  MyFollowingGetUseCase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, OtherUsersDataEntity>> call(
      FollowersFollowingParams params) async {
    return baseUserInfoRepository.getFollowing(params);
  }
}
