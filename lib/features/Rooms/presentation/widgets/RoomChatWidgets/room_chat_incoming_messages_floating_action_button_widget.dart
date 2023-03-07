import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'incoming_bottom_sheet_private_messages.dart';

bool isBottomSheetOpen = false;

class RoomChatIncomingMessagesFloatingActionButtonWidget
    extends StatelessWidget {
  const RoomChatIncomingMessagesFloatingActionButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) => Badge(
        padding: const EdgeInsets.all(AppPadding.p6),
        largeSize: 30,
        smallSize: 20,
        alignment: AlignmentDirectional.topCenter,
        isLabelVisible: state.inComingPrivateChatMessages.isNotEmpty,
        textStyle: Theme.of(context).textTheme.titleSmall,
        label: Text(
          state.inComingPrivateChatMessages.length.toString(),
        ),
        child: IconButton(
          onPressed: () {
            if (isBottomSheetOpen) return;
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return const IncomingPrivateMessagesBottomSheet();
              },
            );
            isBottomSheetOpen = true;
          },
          icon: Icon(
            Icons.message,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
