import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/routes/app_route_names.dart';
import '../../../../../core/utl/utls.dart';
import '../../bloc/sockets/voice/sockets_voice_bloc.dart';

class LeaveRoomAlertDialog extends StatelessWidget {
  const LeaveRoomAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocketsVoiceBloc, SocketsVoiceState>(
      listener: (context, state) {
        if (state.createRoomRequestStatus == CreateRoomRequestStatus.left ||
            state.joinRoomRequestStatus == JoinRoomRequestStatus.left) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutesNames.layoutScreen, (route) => false);
        }
      },
      child: AlertDialog(
        title: Text(
          'Leave Room',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: BlocBuilder<SocketsVoiceBloc, SocketsVoiceState>(
          builder: (context, state) => Text(
            state.isCreateRoom
                ? 'Are you sure you want to leave the room? if you left the room will be deleted'
                : 'Are you sure you want to leave the room?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleMedium,
              )),
          TextButton(
              onPressed: () {
                BlocProvider.of<SocketsVoiceBloc>(context)
                    .add(const LeaveRoomEvent());
                BlocProvider.of<ChatBloc>(context)
                    .add(const LeaveChatRoomEvent());
                Navigator.of(context).pop();
              },
              child: Text(
                'Leave',
                style: Theme.of(context).textTheme.titleMedium,
              )),
        ],
      ),
    );
  }
}
