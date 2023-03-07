import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/RoomChatWidgets/room_chat_incoming_messages_floating_action_button_widget.dart';
import 'package:flutter/material.dart';

Offset offset = const Offset(80, 30);

class OverLayWidget extends StatelessWidget {
  const OverLayWidget({
    super.key,
    required this.overLayEntery,
  });
  final OverlayEntry overLayEntery;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          offset += details.delta;
          overLayEntery.markNeedsBuild();
        },
        child: const RoomChatIncomingMessagesFloatingActionButtonWidget(),
      ),
    );
  }
}
