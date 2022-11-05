import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/entities/auth_entitie.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginUsecase extends BaseUsecase<AuthEntitie, LoginParams> {
  final BaseAuthRepository baseAuthRepository;

  LoginUsecase(this.baseAuthRepository);
  @override
  Future<Either<Failure, AuthEntitie>> call(LoginParams params) async {
    return await baseAuthRepository.login(params);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
