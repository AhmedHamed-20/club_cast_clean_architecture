import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/core/routes/app_route_names.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/RoomChatWidgets/room_chat_incoming_messages_floating_action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'incoming_message_list_tile_widget.dart';

class IncomingPrivateMessagesBottomSheet extends StatefulWidget {
  const IncomingPrivateMessagesBottomSheet({super.key});

  @override
  State<IncomingPrivateMessagesBottomSheet> createState() =>
      _IncomingPrivateMessagesBottomSheetState();
}

class _IncomingPrivateMessagesBottomSheetState
    extends State<IncomingPrivateMessagesBottomSheet> {
  @override
  void dispose() {
    isBottomSheetOpen = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Column(
        children: [
          BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
            if (state.inComingPrivateChatMessages.isEmpty) {
              return const SizedBox.shrink();
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Private Messages',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<ChatBloc>(context)
                          .add(const IncomingMessagesListClearEvent());
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              );
            }
          }),
          BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
            if (state.inComingPrivateChatMessages.isEmpty) {
              return SizedBox(
                  height: MediaQueryOfMethods.getAppHeight(context) * 0.5,
                  child: Center(
                    child: Text(
                      'No Private Messages',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
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
                      onPressedOnTrailing: () {
                        Navigator.of(context).pushNamed(
                          AppRoutesNames.privateChatRoomScreen,
                          arguments: PrivateChatRoomScreenParams(
                            roomUserDataEntitie:
                                state.inComingPrivateChatMessages[index].user!,
                          ),
                        );
                      },
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
