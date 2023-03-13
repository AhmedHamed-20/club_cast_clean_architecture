import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../RoomChatWidgets/room_chat_incoming_messages_floating_action_button_widget.dart';

class InComingMessagesAppBarIcon extends StatelessWidget {
  const InComingMessagesAppBarIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      if (state.inComingPrivateChatMessages.isNotEmpty) {
        return const RoomChatIncomingMessagesFloatingActionButtonWidget();
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
