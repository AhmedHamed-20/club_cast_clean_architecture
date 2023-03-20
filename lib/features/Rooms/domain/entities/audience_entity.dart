// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_entity.dart';

class AudienceEntity extends Equatable {
  final List<ActiveRoomUserDataEntity> audience;

  const AudienceEntity(this.audience);

  AudienceEntity copyWith({
    List<ActiveRoomUserDataEntity>? audience,
  }) {
    return AudienceEntity(
      audience ?? this.audience,
    );
  }

  @override
  List<Object?> get props => [audience];
}
