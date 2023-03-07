import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/sockets/chat/chat_bloc.dart';

class PrivateChatRoomTextFieldWidget extends StatefulWidget {
  const PrivateChatRoomTextFieldWidget({super.key, required this.userId});
  final String userId;
  @override
  State<PrivateChatRoomTextFieldWidget> createState() =>
      _PrivateChatRoomTextFieldWidgetState();
}

class _PrivateChatRoomTextFieldWidgetState
    extends State<PrivateChatRoomTextFieldWidget> {
  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Row(
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.2,
              ),
              child: Defaults.defaultTextFormField(
                  context: context,
                  maxLine: null,
                  labelText: 'Type a message',
                  controller:
                      TextEditingControllers.roomChatPrivateMessageController),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                chatBloc.add(
                  PrivateMessageSendEvent(
                    toUserId: widget.userId,
                    message: TextEditingControllers
                        .roomChatPrivateMessageController.text,
                  ),
                );
                TextEditingControllers.roomChatPrivateMessageController.clear();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor,
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  const CircleBorder(
                    side: BorderSide.none,
                  ),
                ),
              ),
              child: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.primaryContainer,
              )),
        ],
      ),
    );
  }

  void initController() {
    TextEditingControllers.roomChatPrivateMessageController =
        TextEditingController();
  }

  void disposeController() {
    TextEditingControllers.roomChatPrivateMessageController.dispose();
  }
}
