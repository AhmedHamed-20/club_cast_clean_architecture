import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class EventCreateUseCase extends BaseUsecase<void, EventCreateParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  EventCreateUseCase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, void>> call(EventCreateParams params) async {
    return await baseUserInfoRepository.createEvent(params);
  }
}

class EventCreateParams extends Equatable {
  final String accessToken;
  final String eventName;
  final String eventDescription;
  final String eventDate;
  final String eventTime;

  const EventCreateParams(
      {required this.accessToken,
      required this.eventName,
      required this.eventDescription,
      required this.eventDate,
      required this.eventTime});

  @override
  List<Object?> get props => [
        accessToken,
        eventDate,
        eventName,
        eventTime,
        eventDescription,
      ];
}
