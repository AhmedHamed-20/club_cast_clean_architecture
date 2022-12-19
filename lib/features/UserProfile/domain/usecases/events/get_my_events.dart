import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_event_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class MyEventsGetUsecase
    extends BaseUsecase<List<MyEventEntitie>, MyEventsParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  MyEventsGetUsecase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, List<MyEventEntitie>>> call(
      MyEventsParams params) async {
    return await baseUserInfoRepository.getMyEvents(params);
  }
}

class MyEventsParams extends Equatable {
  final String accessToken;

  const MyEventsParams(this.accessToken);

  @override
  List<Object?> get props => [accessToken];
}
