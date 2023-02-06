// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_enitie.dart';

class AudienceEntitie extends Equatable {
  final List<ActiveRoomUserDataEntitie> audience;

  const AudienceEntitie(this.audience);

  AudienceEntitie copyWith({
    List<ActiveRoomUserDataEntitie>? audience,
  }) {
    return AudienceEntitie(
      audience ?? this.audience,
    );
  }

  @override
  List<Object?> get props => [audience];
}
