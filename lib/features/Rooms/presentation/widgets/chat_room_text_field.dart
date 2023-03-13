import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/text_editing_controllers.dart';
import '../../../../core/widgets/defaults.dart';
import '../bloc/sockets/chat/chat_bloc.dart';

class ChatRoomTextField extends StatefulWidget {
  const ChatRoomTextField({super.key});

  @override
  State<ChatRoomTextField> createState() => _ChatRoomTextFieldState();
}

class _ChatRoomTextFieldState extends State<ChatRoomTextField> {
  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQueryOfMethods.getAppHeight(context) * 0.2,
            ),
            child: Defaults.defaultTextFormField(
              context: context,
              labelText: AppStrings.typeAmessage.tr(),
              maxLine: null,
              controller: TextEditingControllers.roomChatMessageController,
            ),
          ),
        ),
        SizedBox(
          width: AppWidth.w10,
        ),
        ElevatedButton(
            onPressed: () {
              chatBloc.add(
                MessageSendEvent(
                  message:
                      TextEditingControllers.roomChatMessageController.text,
                  isPublic: true,
                ),
              );
              TextEditingControllers.roomChatMessageController.clear();
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
    );
  }

  void initControllers() {
    TextEditingControllers.roomChatMessageController = TextEditingController();
  }

  void disposeControllers() {
    TextEditingControllers.roomChatMessageController.dispose();
  }
}
