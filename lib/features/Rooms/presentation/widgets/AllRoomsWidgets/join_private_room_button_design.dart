import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/rooms_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/AllRoomsWidgets/private_room_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/defaults.dart';
import '../../bloc/sockets/chat/chat_bloc.dart';
import '../../bloc/sockets/voice/sockets_voice_bloc.dart';

class JoinPrivateRoomButtonDesign extends StatelessWidget {
  const JoinPrivateRoomButtonDesign({super.key});

  @override
  Widget build(BuildContext context) {
    final socketsVoiceBloc = BlocProvider.of<SocketsVoiceBloc>(context);
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    return Defaults.defaultTextButton(
      onPressed: () {
        if (joinPrivateRoomFormKey.currentState!.validate()) {
          BlocProvider.of<RoomsBloc>(context).add(
            RoomGetByRoomIdEvent(
              accessToken: ConstVar.accessToken,
              roomId:
                  TextEditingControllers.joinPrivateRoomController.text.trim(),
              socketsVoiceBloc: socketsVoiceBloc,
              chatBloc: chatBloc,
            ),
          );
        }
      },
      child: Text(
        'Join',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
