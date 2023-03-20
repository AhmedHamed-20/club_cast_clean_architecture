import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_entity.dart';
import 'package:equatable/equatable.dart';

class MeEntity extends Equatable {
  final ActiveRoomUserDataEntity me;

  const MeEntity(this.me);

  @override
  List<Object?> get props => [me];
}
