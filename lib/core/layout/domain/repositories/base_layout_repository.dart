import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/user_data_entitie.dart';
import 'package:dartz/dartz.dart';

import '../usecases/get_active_user_data.dart';

abstract class BaseLayoutRepository {
  Future<Either<Failure, UserDataEntitie>> getActiveUserData(
      ActiveUserDataGetParams params);
}