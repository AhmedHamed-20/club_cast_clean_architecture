import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_enitie.dart';
import 'package:equatable/equatable.dart';

class MeEntitie extends Equatable {
  final ActiveRoomUserDataEntitie me;

  const MeEntitie(this.me);

  @override
  List<Object?> get props => [me];
}
