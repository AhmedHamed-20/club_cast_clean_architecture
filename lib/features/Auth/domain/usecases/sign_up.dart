import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/entities/auth_entitie.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignUpUsecase extends BaseUsecase<AuthEntitie, SignUpParams> {
  final BaseAuthRepository baseAuthRepository;

  SignUpUsecase(this.baseAuthRepository);
  @override
  Future<Either<Failure, AuthEntitie>> call(SignUpParams params) async {
    return await baseAuthRepository.signUp(params);
  }
}

class SignUpParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  const SignUpParams(
      {required this.name,
      required this.email,
      required this.password,
      required this.confirmPassword});

  @override
  List<Object?> get props => [name, email, password, confirmPassword];
}
