import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utl/utls.dart';
import '../../../../../core/widgets/defaults.dart';
import '../../../../../core/widgets/joining_room_loading_alert_dialog.dart';
import '../../bloc/rooms_bloc.dart';
import '../Events/my_following_events_widget.dart';
import 'all_rooms_main_widget.dart';
import 'join_private_room_dialog.dart';

class HomeMainWidget extends StatelessWidget {
  const HomeMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final roomsBloc = BlocProvider.of<RoomsBloc>(context);
    return BlocListener<SocketsVoiceBloc, SocketsVoiceState>(
      listener: (context, socketVoiceState) {
        if (socketVoiceState.connectToSocketRequestStatus ==
                ConnectToSocketRequestStatus.success &&
            socketVoiceState.joinRoomRequestStatus ==
                JoinRoomRequestStatus.idle) {
          isIuserInRoom = false;
          showDialog(
              context: context,
              builder: (context) => const JoiningRoomAlertLoadingDialog());
        }

        if (socketVoiceState.joinRoomRequestStatus ==
            JoinRoomRequestStatus.left) {
          isIuserInRoom = false;
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Following Events',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: AppHeight.h10),
              const MyFollowingEventsWidget(),
              SizedBox(height: AppHeight.h10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Rooms',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  Defaults.defaultTextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => BlocProvider.value(
                            value: roomsBloc,
                            child: const JoinPrivateRoomDialog()),
                      );
                    },
                    child: Text(
                      'Join private room',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppHeight.h10),
              const AllRoomsMainWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
