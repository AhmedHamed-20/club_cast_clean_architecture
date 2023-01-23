import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/repositories/base_other_user_repository.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/follow_user.dart';
import 'package:dartz/dartz.dart';

class OtherUserUnFollowUsecase extends BaseUsecase<void, FollowUnfollowUserParams> {
  final BaseOtherUserProfilesRepository baseOtherUserProfilesRepository;

  OtherUserUnFollowUsecase(this.baseOtherUserProfilesRepository);
  @override
  Future<Either<Failure, void>> call(FollowUnfollowUserParams params) async {
    return await baseOtherUserProfilesRepository.unFollowUser(params);
  }
}
