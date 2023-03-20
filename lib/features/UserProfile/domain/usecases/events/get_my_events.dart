import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_event_entity.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class MyEventsGetUsecase extends BaseUsecase<MyEventsEntity, MyEventsParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  MyEventsGetUsecase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, MyEventsEntity>> call(MyEventsParams params) async {
    return await baseUserInfoRepository.getMyEvents(params);
  }
}

class MyEventsParams extends Equatable {
  final String accessToken;
  final int page;
  const MyEventsParams({required this.accessToken, required this.page});

  @override
  List<Object?> get props => [accessToken, page];
}
