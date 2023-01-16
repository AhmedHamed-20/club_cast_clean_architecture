import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateUserImageUsecase
    extends BaseUsecase<void, UpdateUserImageUsecaseParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  UpdateUserImageUsecase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, void>> call(
      UpdateUserImageUsecaseParams params) async {
    return await baseUserInfoRepository.updateUserImage(params);
  }
}

class UpdateUserImageUsecaseParams extends Equatable {
  final String imagePath;
  final String accessToken;
  const UpdateUserImageUsecaseParams(
      {required this.imagePath, required this.accessToken});

  @override
  List<Object?> get props => [imagePath, accessToken];
}
