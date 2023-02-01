import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_message_entitie.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/repositories/base_rooms_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RoomMessagesGetUsecase
    extends BaseUsecase<RoomMessageEntitie, RoomMessagesGetParams> {
  final BaseRoomsRepository baseRoomsRepository;

  RoomMessagesGetUsecase(this.baseRoomsRepository);
  @override
  Future<Either<Failure, RoomMessageEntitie>> call(
      RoomMessagesGetParams params) async {
    return await baseRoomsRepository.getRoomMessages(params);
  }
}

class RoomMessagesGetParams extends Equatable {
  final String accessToken;
  final String roomId;
  final int page;
  const RoomMessagesGetParams(
      {required this.accessToken, required this.roomId, required this.page});

  @override
  List<Object?> get props => [accessToken, roomId, page];
}
