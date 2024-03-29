import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/repositories/base_other_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/other_users_data_entity.dart';

class OtherUserProfileDataGetUsecase
    extends BaseUsecase<OtherUserDataEntity, UserProfileDataGetParams> {
  final BaseOtherUserProfilesRepository baseOtherUsersProfilesRepository;

  OtherUserProfileDataGetUsecase(this.baseOtherUsersProfilesRepository);
  @override
  Future<Either<Failure, OtherUserDataEntity>> call(
      UserProfileDataGetParams params) async {
    return await baseOtherUsersProfilesRepository.getOtherUsersProfiles(params);
  }
}

class UserProfileDataGetParams extends Equatable {
  final String userId;
  final String accessToken;

  const UserProfileDataGetParams(
      {required this.userId, required this.accessToken});

  @override
  List<Object> get props => [userId, accessToken];
}
