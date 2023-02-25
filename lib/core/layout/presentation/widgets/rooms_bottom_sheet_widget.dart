import 'package:club_cast_clean_architecture/core/routes/app_route_names.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/join_create_room_entitie.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../../../utl/utls.dart';

class RoomsBottomSheetWidget extends StatelessWidget {
  const RoomsBottomSheetWidget(
      {super.key, required this.joinCreateRoomEntitie});
  final JoinCreateRoomEntitie joinCreateRoomEntitie;
  @override
  Widget build(BuildContext context) {
    final socketBloc = BlocProvider.of<SocketsVoiceBloc>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutesNames.roomScreen);
      },
      child: Container(
        color: AppColors.transparentColor,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  joinCreateRoomEntitie.roomName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              BlocBuilder<SocketsVoiceBloc, SocketsVoiceState>(
                  builder: (context, state) {
                switch (state.liveVoiceRoomFloatingButtonStatus) {
                  case LiveVoiceRoomFloatingButtonStatus.askToTalk:
                    return const SizedBox.shrink();
                  case LiveVoiceRoomFloatingButtonStatus.mute:
                    return IconButton(
                      onPressed: () {
                        socketBloc.add(const MuteUnMuteLocalAudioEvent(true));
                      },
                      icon: Icon(
                        state.liveVoiceRoomFloatingButtonStatus.name == 'mute'
                            ? Icons.mic
                            : Icons.mic_off,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    );
                  case LiveVoiceRoomFloatingButtonStatus.unmute:
                    return IconButton(
                      onPressed: () {
                        socketBloc.add(const MuteUnMuteLocalAudioEvent(false));
                      },
                      icon: Icon(
                        state.liveVoiceRoomFloatingButtonStatus.name == 'mute'
                            ? Icons.mic
                            : Icons.mic_off,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
