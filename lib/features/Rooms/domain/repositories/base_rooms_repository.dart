import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/all_rooms_entitie.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_message_entitie.dart';
import 'package:dartz/dartz.dart';

import '../usecases/get_all_rooms.dart';
import '../usecases/get_room_messages.dart';

abstract class BaseRoomsRepository {
  Future<Either<Failure, AllRoomsEntitie>> getAllRooms(
      AllRoomsGetParams params);

  Future<Either<Failure, RoomMessageEntitie>> getRoomMessages(
      RoomMessagesGetParams params);
}
