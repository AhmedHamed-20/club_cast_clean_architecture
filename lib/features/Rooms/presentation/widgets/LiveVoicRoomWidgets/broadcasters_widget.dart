import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/LiveVoicRoomWidgets/broadcasters_popup_menu_buttons.dart';
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
                  ? Badge(
                      largeSize: 22,
                      alignment: AlignmentDirectional.topEnd,
                      isLabelVisible: state.meEntitie.me.isMutted,
                      label: Icon(
                        Icons.mic_off,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        size: 18,
                      ),
                      child: UserCircleRoomWidget(
                        baseRoomUserDataEntitie: state.meEntitie.me,
                      ),
                    )
                  : PopupMenuButton(
                      itemBuilder: (context) {
                        return popupMenuBroadCastersButtons(
                          context: context,
                          activeRoomUserDataEntitie: state.adminEntitie.admin,
                          iamAdmin: state.isCreateRoom,
                        );
                      },
                      child: Badge(
                        largeSize: 22,
                        alignment: AlignmentDirectional.topEnd,
                        isLabelVisible: state.adminEntitie.admin.isMutted,
                        label: Icon(
                          Icons.mic_off,
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          size: 18,
                        ),
                        child: UserCircleRoomWidget(
                          baseRoomUserDataEntitie: state.adminEntitie.admin,
                        ),
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
                  );
                },
                child: Badge(
                  largeSize: 22,
                  alignment: AlignmentDirectional.topEnd,
                  isLabelVisible:
                      state.brodcastersEnitite.brodcasters[index - 1].isMutted,
                  label: Icon(
                    Icons.mic_off,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    size: 18,
                  ),
                  child: UserCircleRoomWidget(
                    baseRoomUserDataEntitie:
                        state.brodcastersEnitite.brodcasters[index - 1],
                  ),
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
