import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/user_data_entitie.dart';
import '../repositories/base_layout_repository.dart';

class ActiveUserDataGetUseCase
    extends BaseUsecase<UserDataEntitie, ActiveUserDataGetParams> {
  final BaseLayoutRepository baseLayoutRepository;

  ActiveUserDataGetUseCase(this.baseLayoutRepository);
  @override
  Future<Either<Failure, UserDataEntitie>> call(
      ActiveUserDataGetParams params) async {
    return baseLayoutRepository.getActiveUserData(params);
  }
}

class ActiveUserDataGetParams extends Equatable {
  final String accessToken;

  const ActiveUserDataGetParams(this.accessToken);

  @override
  List<Object?> get props => [accessToken];
}
