import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/base_user_info_repository.dart';

class EventRemoveUsecase extends BaseUsecase<void, EventRemoveUsecaseParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  EventRemoveUsecase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, void>> call(EventRemoveUsecaseParams params) async {
    return await baseUserInfoRepository.removeEvent(params);
  }
}

class EventRemoveUsecaseParams extends Equatable {
  final String accessToken;
  final String eventID;

  const EventRemoveUsecaseParams({
    required this.accessToken,
    required this.eventID,
  });

  @override
  List<Object?> get props => [
        accessToken,
        eventID,
      ];
}
