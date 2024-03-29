import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_message_entity_data.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/RoomChatWidgets/room_chat_card_main_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/AppStrings/app_strings.dart';
import '../../../../../core/constants/constants.dart';
import '../../bloc/sockets/chat/chat_bloc.dart';

class ChatTextCardWidget extends StatelessWidget {
  const ChatTextCardWidget(
      {super.key,
      required this.roomMessageDataEntitie,
      this.isPrivateChat = false});

  final RoomMessageDataEntity roomMessageDataEntitie;
  final bool isPrivateChat;
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
          roomMessageDataEntitie.isMine!
              ? Flexible(
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
                          AppStrings.deleteMessage.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                    child: RoomChatCardMainWidget(
                        roomMessageDataEntitie: roomMessageDataEntitie),
                  ),
                )
              : Flexible(
                  child: RoomChatCardMainWidget(
                      isPrivateChat: isPrivateChat,
                      roomMessageDataEntitie: roomMessageDataEntitie),
                ),
        ],
      ),
    );
  }
}
