import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class EventUpdateUsecase extends BaseUsecase<void, EventUpdateUsecaseParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  EventUpdateUsecase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, void>> call(EventUpdateUsecaseParams params) async {
    return await baseUserInfoRepository.updateEvent(params);
  }
}

class EventUpdateUsecaseParams extends Equatable {
  final String accessToken;
  final String eventName;
  final String eventDescription;
  final String eventDate;
  final String eventID;

  const EventUpdateUsecaseParams({
    required this.accessToken,
    required this.eventName,
    required this.eventDescription,
    required this.eventDate,
    required this.eventID,
  });

  @override
  List<Object?> get props => [
        accessToken,
        eventName,
        eventDescription,
        eventDate,
        eventID,
      ];
}
