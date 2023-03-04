import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import '../../features/Rooms/presentation/widgets/AllRoomsWidgets/all_rooms_main_widget.dart';
import '../routes/app_route_names.dart';
import '../utl/utls.dart';

class JoiningRoomAlertLoadingDialog extends StatelessWidget {
  const JoiningRoomAlertLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocketsVoiceBloc, SocketsVoiceState>(
      listener: (context, state) {
        final chatBloc = BlocProvider.of<ChatBloc>(context);
        if (state.joinRoomRequestStatus == JoinRoomRequestStatus.success ||
            state.createRoomRequestStatus == CreateRoomRequestStatus.success &&
                isIuserInRoom == false) {
          chatBloc.add(
            RoomMessagesGetEvent(
              accessToken: ConstVar.accessToken,
              roomId: state.joinCreateRoomEntitie.roomId,
            ),
          );
          chatBloc.add(const ListenOnChatEventsEvent());
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(
            AppRoutesNames.roomScreen,
          );
          //to prevent always pushing to room screen when state changes
          isIuserInRoom = true;
        } else if (state.joinRoomRequestStatus == JoinRoomRequestStatus.error ||
            state.createRoomRequestStatus == CreateRoomRequestStatus.error) {
          Navigator.of(context).pop();
        }
      },
      child: AlertDialog(
        title: Text(
          'Joining Room',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
