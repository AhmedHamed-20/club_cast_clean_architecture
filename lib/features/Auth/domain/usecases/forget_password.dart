import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ForgetPasswordUsecase extends BaseUsecase<void, ForgetPasswordParams> {
  final BaseAuthRepository baseAuthRepository;

  ForgetPasswordUsecase(this.baseAuthRepository);
  @override
  Future<Either<Failure, void>> call(ForgetPasswordParams params) async {
    return await baseAuthRepository.forgetPassword(params);
  }
}

class ForgetPasswordParams extends Equatable {
  final String email;

  const ForgetPasswordParams(this.email);

  @override
  List<Object> get props => [email];
}
