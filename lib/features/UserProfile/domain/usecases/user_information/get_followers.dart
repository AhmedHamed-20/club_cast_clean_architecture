import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/other_users_basic_info_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class MyFollowersGetUseCase
    extends BaseUsecase<OtherUsersDataEntitie, FollowersFollowingParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  MyFollowersGetUseCase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, OtherUsersDataEntitie>> call(
      FollowersFollowingParams params) async {
    return baseUserInfoRepository.getFollowers(params);
  }
}

class FollowersFollowingParams extends Equatable {
  final String accessToken;
  final int page;
  const FollowersFollowingParams(
      {required this.accessToken, required this.page});

  @override
  List<Object?> get props => [accessToken];
}
