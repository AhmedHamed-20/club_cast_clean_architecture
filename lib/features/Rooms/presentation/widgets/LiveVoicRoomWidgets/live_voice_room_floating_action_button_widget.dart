import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utl/utls.dart';

class RoomVoiceFloatingActionButtonWidget extends StatelessWidget {
  const RoomVoiceFloatingActionButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final socketBloc = BlocProvider.of<SocketsVoiceBloc>(context);
    return BlocBuilder<SocketsVoiceBloc, SocketsVoiceState>(
        builder: (context, state) {
      switch (state.liveVoiceRoomFloatingButtonStatus) {
        case LiveVoiceRoomFloatingButtonStatus.askToTalk:
          return FloatingActionButton(
            onPressed: () {
              socketBloc.add(const AskToTalkEvent());
            },
            child: Icon(
              Icons.back_hand,
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        case LiveVoiceRoomFloatingButtonStatus.mute:
          return FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.mic,
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        case LiveVoiceRoomFloatingButtonStatus.unmute:
          return FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.mic_off,
              color: Theme.of(context).colorScheme.primary,
            ),
          );
      }
    });
  }
}
