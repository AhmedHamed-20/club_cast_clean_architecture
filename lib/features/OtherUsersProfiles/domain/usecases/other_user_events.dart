import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_event.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/repositories/base_other_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class OtherUserEventsUsecase
    extends BaseUsecase<OtherUserEventsEntitie, OtherUserEventsParams> {
  final BaseOtherUserProfilesRepository baseOtherUserProfilesRepository;

  OtherUserEventsUsecase(this.baseOtherUserProfilesRepository);
  @override
  Future<Either<Failure, OtherUserEventsEntitie>> call(
      OtherUserEventsParams params) async {
    return await baseOtherUserProfilesRepository.getOtherUserEvents(params);
  }
}

class OtherUserEventsParams extends Equatable {
  final String userId;
  final int page;
  final String accessToken;

  const OtherUserEventsParams(
      {required this.userId, required this.accessToken, required this.page});

  @override
  List<Object?> get props => [userId, accessToken, page];
}
