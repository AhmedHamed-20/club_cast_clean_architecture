import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/repositories/base_other_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class OtherUserFollowUsecase extends BaseUsecase<void, FollowUnfollowUserParams> {
  final BaseOtherUserProfilesRepository baseOtherUserProfilesRepository;

  OtherUserFollowUsecase(this.baseOtherUserProfilesRepository);

  @override
  Future<Either<Failure, void>> call(FollowUnfollowUserParams params) async {
    return await baseOtherUserProfilesRepository.followUser(params);
  }
}

class FollowUnfollowUserParams extends Equatable {
  final String accessToken;
  final String userId;

  const FollowUnfollowUserParams(
      {required this.accessToken, required this.userId});

  @override
  List<Object?> get props => [accessToken, userId];
}
