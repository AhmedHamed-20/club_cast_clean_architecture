import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/my_following_events_entitie.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/repositories/base_layout_repository.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class MyFollowingEventsUsecase
    extends BaseUsecase<MyFollowingEventsEntitie, MyFollowingEventsParams> {
  final BaseLayoutRepository baseLayoutRepository;

  MyFollowingEventsUsecase(this.baseLayoutRepository);
  @override
  Future<Either<Failure, MyFollowingEventsEntitie>> call(
      MyFollowingEventsParams params) async {
    return await baseLayoutRepository.getMyFollowingEvents(params);
  }
}

class MyFollowingEventsParams extends Equatable {
  final String accessToken;

  const MyFollowingEventsParams(this.accessToken);

  @override
  List<Object?> get props => [accessToken];
}
