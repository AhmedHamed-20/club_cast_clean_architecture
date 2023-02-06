import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_message_entitie_data.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/RoomChatWidgets/room_chat_card_main_widget.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/RoomChatWidgets/room_chat_card_user_photo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../bloc/sockets/chat/chat_bloc.dart';
import 'chat_room_card_user_information_widget.dart';

class ChatTextCardWidget extends StatelessWidget {
  const ChatTextCardWidget({super.key, required this.roomMessageDataEntitie});

  final RoomMessageDataEntitie roomMessageDataEntitie;
  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Row(
        mainAxisAlignment: roomMessageDataEntitie.isMine!
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Flexible(
            child: PopupMenuButton(
              shadowColor: Theme.of(context).colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r12)),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    chatBloc.add(
                      MessageRemoveEvent(
                        messageId: roomMessageDataEntitie.messageId!,
                      ),
                    );
                  },
                  value: 1,
                  child: Text(
                    'Delete Message',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
              child: RoomChatCardMainWidget(
                  roomMessageDataEntitie: roomMessageDataEntitie),
            ),
          ),
        ],
      ),
    );
  }
}
