import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_card_widget.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
        return ListView.builder(
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
}

List chatFake = [
  {'message': 'hamed', 'isMe': false},
  {'message': 'hamed', 'isMe': true},
  {'message': 'hamed', 'isMe': false},
  {'message': 'hamed', 'isMe': true},
  {'message': 'hamed', 'isMe': false},
  {'message': 'hamed', 'isMe': false},
  {'message': 'hamed', 'isMe': false},
  {'message': 'hamed', 'isMe': false},
];
