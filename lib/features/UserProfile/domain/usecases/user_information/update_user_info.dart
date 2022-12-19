import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/updated_user_data_info.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UserDataUpdateUseCase
    extends BaseUsecase<UpdatedUserDataInfoEntitie, UserDataUpdateParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  UserDataUpdateUseCase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, UpdatedUserDataInfoEntitie>> call(
      UserDataUpdateParams params) async {
    return await baseUserInfoRepository.updateUserData(params);
  }
}

class UserDataUpdateParams extends Equatable {
  final String accessToken;
  final String email;
  final String name;
  final String bio;

  const UserDataUpdateParams(
      {required this.email,
      required this.name,
      required this.bio,
      required this.accessToken});

  @override
  List<Object?> get props => [name, email, bio, accessToken];
}
