// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_user_data.dart';

class RoomMessageDataEntity extends Equatable {
  final String message;
  final bool isPublic;
  final bool? isMine;
  final String? messageId;
  final String? createdAt;
  final RoomUserDataEntity? user;
  final String? toUserId;

  const RoomMessageDataEntity(
      {required this.message,
      required this.isPublic,
      this.messageId,
      this.createdAt,
      this.user,
      this.isMine,
      this.toUserId});

  RoomMessageDataEntity copyWith({
    String? message,
    bool? isPublic,
    String? createdAt,
    bool? isMine,
    String? messageId,
    RoomUserDataEntity? user,
    String? toUserId,
  }) {
    return RoomMessageDataEntity(
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
      isPublic: isPublic ?? this.isPublic,
      isMine: isMine ?? this.isMine,
      messageId: messageId ?? this.messageId,
      user: user ?? this.user,
      toUserId: toUserId ?? this.toUserId,
    );
  }

  @override
  List<Object?> get props =>
      [message, isPublic, user, toUserId, messageId, isMine, createdAt];
}
