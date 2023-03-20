import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_entity.dart';
import 'package:equatable/equatable.dart';

class AdminEntity extends Equatable {
  final ActiveRoomUserDataEntity admin;

  const AdminEntity(this.admin);

  @override
  List<Object?> get props => [admin];
}
