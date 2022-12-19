import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class PasswordUpdateUseCase extends BaseUsecase<String, PasswordUpdateParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  PasswordUpdateUseCase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, String>> call(PasswordUpdateParams params) async {
    return await baseUserInfoRepository.updatePassword(params);
  }
}

class PasswordUpdateParams extends Equatable {
  final String accessToken;
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const PasswordUpdateParams(
      {required this.accessToken,
      required this.currentPassword,
      required this.newPassword,
      required this.confirmPassword});

  @override
  List<Object?> get props => [
        accessToken,
        currentPassword,
        confirmPassword,
        newPassword,
      ];
}
