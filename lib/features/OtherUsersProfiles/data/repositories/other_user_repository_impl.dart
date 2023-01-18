import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_users_data_entitie.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/repositories/base_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/get_user_profile_data.dart';

import '../datasources/remote_other_users_data_source.dart';

class OtherUserProfileRepositoryImpl extends BaseOtherUserProfilesRepository {
  final BaseRemoteOtherUsersDataSorce baseRemoteOtherUsersDataSorce;

  OtherUserProfileRepositoryImpl(this.baseRemoteOtherUsersDataSorce);
  @override
  Future<Either<Failure, OtherUserDataEntitie>> getOtherUsersProfiles(
      UserProfileDataGetParams params) async {
    try {
      final result =
          await baseRemoteOtherUsersDataSorce.getOtherUsersProfiles(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          message: e.serverErrorMessageModel.message,
          statusCode: e.serverErrorMessageModel.statusCode));
    }
  }
}
