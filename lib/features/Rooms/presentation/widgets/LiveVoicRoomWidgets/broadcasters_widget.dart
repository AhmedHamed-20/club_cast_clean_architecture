import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/LiveVoicRoomWidgets/popup_menu_buttons.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/LiveVoicRoomWidgets/user_circle_room_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/sockets/voice/sockets_voice_bloc.dart';

class BroadcastersWidget extends StatelessWidget {
  const BroadcastersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketsVoiceBloc, SocketsVoiceState>(
      builder: (context, state) => SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index <= 0) {
              return state.isCreateRoom
                  ? UserCircleRoomWidget(
                      baseRoomUserDataEntitie: state.meEntitie.me,
                    )
                  : PopupMenuButton(
                      itemBuilder: (context) {
                        return popupMenuBroadCastersButtons(
                          context: context,
                          activeRoomUserDataEntitie: state.adminEntitie.admin,
                          iamAdmin: state.isCreateRoom,
                          iMuteHim: state.adminEntitie.admin.iMuteHim,
                        );
                      },
                      child: UserCircleRoomWidget(
                        baseRoomUserDataEntitie: state.adminEntitie.admin,
                      ),
                    );
            } else {
              return PopupMenuButton(
                itemBuilder: (context) {
                  return popupMenuBroadCastersButtons(
                    context: context,
                    iamAdmin: state.isCreateRoom,
                    activeRoomUserDataEntitie:
                        state.brodcastersEnitite.brodcasters[index - 1],
                    iMuteHim: state
                        .brodcastersEnitite.brodcasters[index - 1].iMuteHim,
                  );
                },
                child: UserCircleRoomWidget(
                  baseRoomUserDataEntitie:
                      state.brodcastersEnitite.brodcasters[index - 1],
                ),
              );
            }
          },
          childCount: state.brodcastersEnitite.brodcasters.length + 1,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
      ),
    );
  }
}
