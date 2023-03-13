import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
    final layoutBloc = BlocProvider.of<LayoutBloc>(context);
    return BlocListener<SocketsVoiceBloc, SocketsVoiceState>(
      listener: (context, socketVoiceState) {
        if (socketVoiceState.connectToSocketRequestStatus ==
                ConnectToSocketRequestStatus.success &&
            socketVoiceState.joinRoomRequestStatus ==
                JoinRoomRequestStatus.loading) {
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
      child: RefreshIndicator(
        onRefresh: () async {
          roomsBloc.add(AllRoomsGetEvent(accessToken: ConstVar.accessToken));
          layoutBloc.add(MyFollowingEventsGetEvent(ConstVar.accessToken));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.yourFollowingEvents.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: AppHeight.h10),
                const MyFollowingEventsWidget(),
                SizedBox(height: AppHeight.h10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.allRooms.tr(),
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
                        AppStrings.joinPrivateRoom.tr(),
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
      ),
    );
  }
}
