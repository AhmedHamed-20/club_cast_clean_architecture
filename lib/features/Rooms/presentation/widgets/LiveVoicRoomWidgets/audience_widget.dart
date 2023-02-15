import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/LiveVoicRoomWidgets/user_circle_room_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/sockets/voice/sockets_voice_bloc.dart';
import 'listeners_popup_menu_buttons.dart';

class AudienceWidget extends StatelessWidget {
  const AudienceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketsVoiceBloc, SocketsVoiceState>(
      builder: (context, state) => SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return PopupMenuButton(
              itemBuilder: (context) {
                return popupMenuListenersButtons(
                  context: context,
                  iamAdmin: state.isCreateRoom,
                  activeRoomUserDataEntitie:
                      state.audienceEntitie.audience[index],
                  iMuteHim: state.audienceEntitie.audience[index].iMuteHim,
                );
              },
              child: Stack(alignment: Alignment.center, children: [
                UserCircleRoomWidget(
                  baseRoomUserDataEntitie:
                      state.audienceEntitie.audience[index],
                ),
                state.audienceEntitie.audience[index].askedToSpeak
                    ? Positioned(
                        top: 0,
                        right: 10,
                        child: Icon(
                          Icons.back_hand,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : const SizedBox.shrink(),
              ]),
            );
          },
          childCount: state.audienceEntitie.audience.length,
        ),
      ),
    );
  }
}
