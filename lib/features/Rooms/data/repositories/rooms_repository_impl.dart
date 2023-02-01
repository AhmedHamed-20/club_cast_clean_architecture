import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/datasources/remote_rooms_data_source.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/all_rooms_entitie.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_message_entitie.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/repositories/base_rooms_repository.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/usecases/get_room_messages.dart';
import 'package:dartz/dartz.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/usecases/get_all_rooms.dart';

class RoomsRepositoryImpl extends BaseRoomsRepository {
  final BaseRemoteRoomsDataSource baseRemoteRoomsDataSource;

  RoomsRepositoryImpl(this.baseRemoteRoomsDataSource);
  @override
  Future<Either<Failure, AllRoomsEntitie>> getAllRooms(
      AllRoomsGetParams params) async {
    try {
      final result = await baseRemoteRoomsDataSource.getAllRooms(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          message: e.serverErrorMessageModel.message,
          statusCode: e.serverErrorMessageModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, RoomMessageEntitie>> getRoomMessages(
      RoomMessagesGetParams params) async {
    try {
      final result = await baseRemoteRoomsDataSource.getRoomMessage(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          message: e.serverErrorMessageModel.message,
          statusCode: e.serverErrorMessageModel.statusCode));
    }
  }
}
