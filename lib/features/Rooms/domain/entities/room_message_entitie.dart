// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_message_entity_data.dart';

class RoomMessageEntitie extends Equatable {
  final int results;
  final List<RoomMessageDataEntity> roomMessages;

  const RoomMessageEntitie({
    required this.results,
    required this.roomMessages,
  });

  RoomMessageEntitie copyWith({
    int? results,
    List<RoomMessageDataEntity>? roomMessages,
  }) {
    return RoomMessageEntitie(
      results: results ?? this.results,
      roomMessages: roomMessages ?? this.roomMessages,
    );
  }

  @override
  List<Object?> get props => [results, roomMessages];
}
