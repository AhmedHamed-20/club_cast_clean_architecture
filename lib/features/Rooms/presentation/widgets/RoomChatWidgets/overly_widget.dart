import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/RoomChatWidgets/room_chat_incoming_messages_floating_action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Offset offset = const Offset(80, 30);

class OverLayWidget extends StatelessWidget {
  const OverLayWidget({
    super.key,
    required this.overLayEntery,
  });
  final OverlayEntry overLayEntery;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SocketsBloc, SocketsState>(
      listener: (context, state) {
        if (state.createRoomRequestStatus == CreateRoomRequestStatus.left ||
            state.joinRoomRequestStatus == JoinRoomRequestStatus.left) {
          overLayEntery.remove();
        }
      },
      child: Positioned(
          left: offset.dx,
          top: offset.dy,
          child: GestureDetector(
              onPanUpdate: (details) {
                offset += details.delta;
                overLayEntery.markNeedsBuild();
              },
              child:
                  const RoomChatIncomingMessagesFloatingActionButtonWidget())),
    );
  }
}
