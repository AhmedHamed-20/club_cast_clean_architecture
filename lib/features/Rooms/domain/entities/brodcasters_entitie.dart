import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_enitie.dart';
import 'package:equatable/equatable.dart';

class BrodcastersEnitite extends Equatable {
  final List<ActiveRoomUserDataEntitie> brodcasters;

  const BrodcastersEnitite(this.brodcasters);

  @override
  List<Object?> get props => [brodcasters];
}
