import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_card_widget.dart';

late ScrollController chatRoomScrollController;

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  void initState() {
    super.initState();
    initScrollController();
  }

  @override
  void dispose() {
    disposeScrollController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
        return ListView.builder(
            controller: chatRoomScrollController,
            itemCount: state.roomMessageEntitie.roomMessages.length,
            itemBuilder: (context, index) {
              return ChatTextCardWidget(
                roomMessageDataEntitie:
                    state.roomMessageEntitie.roomMessages[index],
              );
            });
      }),
    );
  }

  void initScrollController() {
    chatRoomScrollController = ScrollController();
  }

  void disposeScrollController() {
    chatRoomScrollController.dispose();
  }
}
