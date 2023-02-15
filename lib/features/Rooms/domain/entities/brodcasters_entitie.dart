// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_enitie.dart';

class BrodcastersEntitie extends Equatable {
  final List<ActiveRoomUserDataEntitie> brodcasters;

  const BrodcastersEntitie(this.brodcasters);

  BrodcastersEntitie copyWith({
    List<ActiveRoomUserDataEntitie>? brodcasters,
  }) {
    return BrodcastersEntitie(
      brodcasters ?? this.brodcasters,
    );
  }

  @override
  List<Object?> get props => [brodcasters];
}
