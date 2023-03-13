import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/AppStrings/app_strings.dart';
import '../RoomChatWidgets/chat_card_widget.dart';

late ScrollController privateChatRoomScrollController;

class PrivateChatRoomMessagesWidget extends StatefulWidget {
  const PrivateChatRoomMessagesWidget({super.key, required this.params});
  final PrivateChatRoomScreenParams params;

  @override
  State<PrivateChatRoomMessagesWidget> createState() =>
      _PrivateChatRoomMessagesWidgetState();
}

class _PrivateChatRoomMessagesWidgetState
    extends State<PrivateChatRoomMessagesWidget> {
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
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      if (state.privateChatMessages == const {} ||
          state.privateChatMessages?[widget.params.roomUserDataEntitie.id] ==
              null) {
        return Expanded(
          child: Center(
              child: Text(
            AppStrings.noMessagesYet.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          )),
        );
      } else {
        return Expanded(
          child: ListView.builder(
              controller: privateChatRoomScrollController,
              itemCount: state
                  .privateChatMessages![widget.params.roomUserDataEntitie.id]!
                  .length,
              itemBuilder: (context, index) {
                return ChatTextCardWidget(
                  roomMessageDataEntitie: state.privateChatMessages![
                      widget.params.roomUserDataEntitie.id]![index],
                );
              }),
        );
      }
    });
  }

  void initScrollController() {
    privateChatRoomScrollController = ScrollController();
  }

  void disposeScrollController() {
    privateChatRoomScrollController.dispose();
  }
}
