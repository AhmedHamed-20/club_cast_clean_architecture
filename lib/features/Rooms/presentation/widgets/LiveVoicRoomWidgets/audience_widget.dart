import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/LiveVoicRoomWidgets/user_circle_room_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/sockets/voice/sockets_voice_bloc.dart';

class AudienceWidget extends StatelessWidget {
  const AudienceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketsBloc, SocketsState>(
      builder: (context, state) => SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (state.isCreateRoom) {
              return Stack(alignment: Alignment.center, children: [
                UserCircleRoomWidget(
                  baseRoomUserDataEntitie:
                      state.audienceEntitie!.audience[index],
                ),
                state.audienceEntitie!.audience[index].askedToSpeak
                    ? Positioned(
                        top: 0,
                        right: 10,
                        child: Icon(
                          Icons.back_hand,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : const SizedBox.shrink(),
              ]);
            } else {
              if (index < state.audienceEntitie!.audience.length &&
                  state.audienceEntitie!.audience.isNotEmpty) {
                return Stack(alignment: Alignment.center, children: [
                  UserCircleRoomWidget(
                    baseRoomUserDataEntitie:
                        state.audienceEntitie!.audience[index],
                  ),
                  state.audienceEntitie!.audience[index].askedToSpeak
                      ? Positioned(
                          top: 0,
                          right: 10,
                          child: Icon(
                            Icons.back_hand,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : const SizedBox.shrink(),
                ]);
              } else {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    UserCircleRoomWidget(
                      baseRoomUserDataEntitie: state.meEntitie!.me,
                    ),
                    state.meEntitie!.me.askedToSpeak
                        ? Positioned(
                            top: 0,
                            right: 10,
                            child: Icon(
                              Icons.back_hand,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              }
            }
          },
          childCount: state.isCreateRoom
              ? state.audienceEntitie!.audience.length
              : state.audienceEntitie!.audience.length + 1,
        ),
      ),
    );
  }
}
