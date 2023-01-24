import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/all_rooms_entitie.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/base_rooms_repository.dart';

class AllRoomsGetUsecase
    extends BaseUsecase<AllRoomsEntitie, AllRoomsGetParams> {
  final BaseRoomsRepository baseRoomsRepository;

  AllRoomsGetUsecase(this.baseRoomsRepository);
  @override
  Future<Either<Failure, AllRoomsEntitie>> call(
      AllRoomsGetParams params) async {
    return await baseRoomsRepository.getAllRooms(params);
  }
}

class AllRoomsGetParams extends Equatable {
  final String accessToken;
  final int page;

  const AllRoomsGetParams({required this.accessToken, required this.page});

  @override
  List<Object?> get props => [accessToken, page];
}
