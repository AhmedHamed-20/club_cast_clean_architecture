import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/entities/room_message_entitie_data.dart';

class RoomChatCardUserInformationWidget extends StatelessWidget {
  const RoomChatCardUserInformationWidget({
    super.key,
    required this.roomMessageDataEntitie,
  });

  final RoomMessageDataEntitie roomMessageDataEntitie;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: roomMessageDataEntitie.isMine!
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (!roomMessageDataEntitie.isMine!)
            Text(
              roomMessageDataEntitie.user!.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          SizedBox(height: AppHeight.h10),
          Text(
            roomMessageDataEntitie.message,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: AppHeight.h10),
          Text(
            DateTimeFormat.format(
              DateTime.parse(roomMessageDataEntitie.createdAt!).toLocal(),
              format: 'H:i',
            ),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
          ),
        ],
      ),
    );
  }
}
