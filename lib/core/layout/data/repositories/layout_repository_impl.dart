import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/layout/data/datasources/layout_remote_data_source_impl.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/user_data_entitie.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/repositories/base_layout_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_active_user_data.dart';

class LayoutRepositoryImpl extends BaseLayoutRepository {
  final BaseLayoutRemoteDataSource baseLayoutRemoteDataSource;

  LayoutRepositoryImpl(this.baseLayoutRemoteDataSource);
  @override
  Future<Either<Failure, UserDataEntitie>> getActiveUserData(
      ActiveUserDataGetParams params) async {
    try {
      final result = await baseLayoutRemoteDataSource.getActiveUserData(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(
          ServerFailure(message: exception.serverErrorMessageModel.message));
    }
  }
}
