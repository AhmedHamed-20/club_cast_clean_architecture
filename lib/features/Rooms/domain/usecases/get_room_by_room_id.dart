import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/all_rooms_entity_data.dart';
import '../repositories/base_rooms_repository.dart';

class RoomGetByRoomIdUseCase
    extends BaseUsecase<AllRoomsDataEntity, RoomGetByRoomIdParams> {
  final BaseRoomsRepository baseRoomsRepository;

  RoomGetByRoomIdUseCase(this.baseRoomsRepository);
  @override
  Future<Either<Failure, AllRoomsDataEntity>> call(
      RoomGetByRoomIdParams params) async {
    return await baseRoomsRepository.getRoomById(params);
  }
}

class RoomGetByRoomIdParams extends Equatable {
  final String accessToken;
  final String roomId;

  const RoomGetByRoomIdParams(
      {required this.accessToken, required this.roomId});

  @override
  List<Object?> get props => [accessToken, roomId];
}
