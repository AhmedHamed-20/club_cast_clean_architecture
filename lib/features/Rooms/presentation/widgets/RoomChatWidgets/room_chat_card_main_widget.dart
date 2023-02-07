import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/RoomChatWidgets/room_chat_card_user_photo_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/entities/room_message_entitie_data.dart';
import 'chat_room_card_user_information_widget.dart';

class RoomChatCardMainWidget extends StatelessWidget {
  const RoomChatCardMainWidget({
    super.key,
    required this.roomMessageDataEntitie,
  });

  final RoomMessageDataEntitie roomMessageDataEntitie;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: roomMessageDataEntitie.isMine!
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (!roomMessageDataEntitie.isMine!)
          RoomChatCardUserPhotoWidget(
              roomMessageDataEntitie: roomMessageDataEntitie),
        Flexible(
          child: Card(
            color: roomMessageDataEntitie.isMine!
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.secondaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(AppRadius.r8),
                topRight: const Radius.circular(AppRadius.r8),
                bottomLeft: roomMessageDataEntitie.isMine!
                    ? const Radius.circular(AppRadius.r8)
                    : const Radius.circular(0),
                bottomRight: roomMessageDataEntitie.isMine!
                    ? const Radius.circular(0)
                    : const Radius.circular(AppRadius.r8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: roomMessageDataEntitie.isMine!
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoomChatCardUserInformationWidget(
                      roomMessageDataEntitie: roomMessageDataEntitie),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
