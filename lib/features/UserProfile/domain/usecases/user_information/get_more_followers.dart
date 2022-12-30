import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/other_users_basic_info_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class MoreFollowersGetUsecase extends BaseUsecase<OtherUsersDataEntitie,
    MoreFollowersFollowingGetParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  MoreFollowersGetUsecase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, OtherUsersDataEntitie>> call(
      MoreFollowersFollowingGetParams params) async {
    return await baseUserInfoRepository.getMoreFollowers(params);
  }
}

class MoreFollowersFollowingGetParams extends Equatable {
  final String accessToken;
  final String page;

  const MoreFollowersFollowingGetParams(
      {required this.accessToken, required this.page});

  @override
  List<Object?> get props => [accessToken, page];
}
