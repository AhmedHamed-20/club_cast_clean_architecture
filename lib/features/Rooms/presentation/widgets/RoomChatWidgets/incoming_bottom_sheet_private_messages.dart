import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'incoming_message_list_tile_widget.dart';

class IncomingPrivateMessagesBottomSheet extends StatelessWidget {
  const IncomingPrivateMessagesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Column(
        children: [
          Text(
            'Incoming Private Messages',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
            if (state.inComingPrivateChatMessages.isEmpty) {
              return Center(
                  child: Text(
                'No Private Messages',
                style: Theme.of(context).textTheme.titleLarge,
              ));
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.inComingPrivateChatMessages.length,
                  itemBuilder: (context, index) {
                    return IncomingMessageListTileWidget(
                      userName:
                          state.inComingPrivateChatMessages[index].user!.name,
                      userPhoto:
                          state.inComingPrivateChatMessages[index].user!.photo,
                      message: state.inComingPrivateChatMessages[index].message,
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
