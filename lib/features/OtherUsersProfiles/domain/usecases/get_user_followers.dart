import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/followers_following_data_entity.dart';
import '../repositories/base_other_user_repository.dart';

class OtherUserFollowersUsecase extends BaseUsecase<
    OtherUserFollowersFollowingDataEntity, OtherUserFollowersFollowingParams> {
  final BaseOtherUserProfilesRepository baseOtherUserProfilesRepository;

  OtherUserFollowersUsecase(this.baseOtherUserProfilesRepository);
  @override
  Future<Either<Failure, OtherUserFollowersFollowingDataEntity>> call(
      OtherUserFollowersFollowingParams params) async {
    return await baseOtherUserProfilesRepository.getUserFollowers(params);
  }
}

class OtherUserFollowersFollowingParams extends Equatable {
  final String uid;
  final String accessToken;
  final int page;
  const OtherUserFollowersFollowingParams({
    required this.uid,
    required this.accessToken,
    required this.page,
  });

  @override
  List<Object?> get props => [
        uid,
        accessToken,
        page,
      ];
}
