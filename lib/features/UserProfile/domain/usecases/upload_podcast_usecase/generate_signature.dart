import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../entities/signature_entity.dart';

class SignatureGenerateUsecase
    extends BaseUsecase<SignatureEntity, SignatureGenerateParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  SignatureGenerateUsecase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, SignatureEntity>> call(
      SignatureGenerateParams params) async {
    return await baseUserInfoRepository.generateSignature(params);
  }
}

class SignatureGenerateParams extends Equatable {
  final String accessToken;

  const SignatureGenerateParams(this.accessToken);

  @override
  List<Object?> get props => [accessToken];
}
