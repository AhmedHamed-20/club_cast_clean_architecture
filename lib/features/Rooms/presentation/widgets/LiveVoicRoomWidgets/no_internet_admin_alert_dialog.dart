import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../bloc/sockets/chat/chat_bloc.dart';
import '../../bloc/sockets/voice/sockets_voice_bloc.dart';

class AdminNoInternetlertDialog extends StatelessWidget {
  const AdminNoInternetlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final socketsVoiceBloc = BlocProvider.of<SocketsVoiceBloc>(context);
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    return BlocBuilder<SocketsVoiceBloc, SocketsVoiceState>(
      builder: (context, state) => AlertDialog(
        title: Text(
          'No Internet connection',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'You are not connected to the internet, please connect to the internet within 1 minute or you will be disconnected from the room and the room will be deleted',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (await InternetConnectionChecker().hasConnection == false) {
                flutterToast(
                    msg: 'You are still not connected to the internet',
                    backgroundColor: AppColors.toastWarning,
                    textColor: AppColors.black);
              } else {
                socketsVoiceBloc.add(ConnectToSocketEvent(
                    accessToken: ConstVar.accessToken,
                    isCreateRoom: false,
                    roomName: state.joinCreateRoomEntitie.roomName));
              }
            },
            child: Text(
              'Recconect',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              socketsVoiceBloc.add(const LeaveRoomEvent());
              chatBloc.add(const LeaveChatRoomEvent());
            },
            child: Text(
              'leave',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
