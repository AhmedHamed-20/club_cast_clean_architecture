import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/other_users_basic_info_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'get_more_followers.dart';

class MoreFollowingGetUsecase extends BaseUsecase<OtherUsersDataEntitie,
    MoreFollowersFollowingGetParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  MoreFollowingGetUsecase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, OtherUsersDataEntitie>> call(
      MoreFollowersFollowingGetParams params) async {
    return await baseUserInfoRepository.getMoreFollowing(params);
  }
}
