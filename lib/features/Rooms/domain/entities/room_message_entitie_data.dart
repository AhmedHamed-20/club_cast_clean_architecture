import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_user_data.dart';
import 'package:equatable/equatable.dart';

class RoomMessageDataEntitie extends Equatable {
  final String message;
  final bool isPublic;
  final RoomUserDataEntitie? user;
  final String? toUserId;

  const RoomMessageDataEntitie(
      {required this.message,
      required this.isPublic,
      this.user,
      this.toUserId});

  @override
  List<Object?> get props => [message, isPublic, user, toUserId];
}
