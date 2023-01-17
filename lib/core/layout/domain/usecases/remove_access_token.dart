import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/base_layout_repository.dart';

class AccessTokenRemoveUsecase
    extends BaseUsecase<void, AccessTokenRemoveParams> {
  final BaseLayoutRepository repository;

  AccessTokenRemoveUsecase(this.repository);
  @override
  Future<Either<Failure, void>> call(AccessTokenRemoveParams params) async {
    return await repository.removeCachedAccessToken(params);
  }
}

class AccessTokenRemoveParams extends Equatable {
  final String key;

  const AccessTokenRemoveParams({required this.key});

  @override
  List<Object?> get props => [key];
}
