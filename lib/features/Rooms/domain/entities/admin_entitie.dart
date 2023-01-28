import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_enitie.dart';
import 'package:equatable/equatable.dart';

class AdminEntitie extends Equatable {
  final ActiveRoomUserDataEntitie admin;

  const AdminEntitie(this.admin);

  @override
  List<Object?> get props => [admin];
}
