// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_entity.dart';

class BrodcastersEntity extends Equatable {
  final List<ActiveRoomUserDataEntity> brodcasters;

  const BrodcastersEntity(this.brodcasters);

  BrodcastersEntity copyWith({
    List<ActiveRoomUserDataEntity>? brodcasters,
  }) {
    return BrodcastersEntity(
      brodcasters ?? this.brodcasters,
    );
  }

  @override
  List<Object?> get props => [brodcasters];
}
