import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_message_entitie_data.dart';
import 'package:equatable/equatable.dart';

class RoomMessageEntitie extends Equatable {
  final int results;
  final List<RoomMessageDataEntitie> roomMessages;

  const RoomMessageEntitie({
    required this.results,
    required this.roomMessages,
  });

  @override
  List<Object?> get props => [results, roomMessages];
}
