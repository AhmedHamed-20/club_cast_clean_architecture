import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/followers_following_data_entitie.dart';
import '../repositories/base_other_user_repository.dart';
import 'get_user_followers.dart';

class OtherUserFollowingUsecase extends BaseUsecase<
    OtherUserFollowersFollowingDataEntitie, OtherUserFollowersFollowingParams> {
  final BaseOtherUserProfilesRepository baseOtherUserProfilesRepository;

  OtherUserFollowingUsecase(this.baseOtherUserProfilesRepository);
  @override
  Future<Either<Failure, OtherUserFollowersFollowingDataEntitie>> call(
      OtherUserFollowersFollowingParams params) async {
    return await baseOtherUserProfilesRepository.getUserFollowing(params);
  }
}
