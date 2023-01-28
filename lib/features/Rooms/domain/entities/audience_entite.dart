import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_enitie.dart';
import 'package:equatable/equatable.dart';

class AudienceEntitie extends Equatable {
  final List<ActiveRoomUserDataEntitie> audience;

  const AudienceEntitie(this.audience);

  @override
  List<Object?> get props => [audience];
}
