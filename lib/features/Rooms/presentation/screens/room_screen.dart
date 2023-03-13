import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/AllRoomsWidgets/incomiong_messages_app_bar_icon.dart';
import '../widgets/AllRoomsWidgets/show_recoding_path_widget.dart';
import '../widgets/LiveVoicRoomWidgets/live_voice_room_widget.dart';
import '../widgets/LiveVoicRoomWidgets/room_name_leave_widget.dart';
import '../widgets/LiveVoicRoomWidgets/share_room_id_widget.dart';
import '../widgets/RoomChatWidgets/room_chat_widget.dart';

OverlayEntry? overLayEntery;

PageController pageViewScrollController = PageController();
int currentPageIndex = 0;
final GlobalKey roomsWidgetKey = GlobalKey();

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: roomsWidgetKey,
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                text: AppStrings.liveVoiceRoom.tr(),
              ),
              Tab(
                text: AppStrings.roomChat.tr(),
              ),
            ],
            labelStyle: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
          title: BlocBuilder<SocketsVoiceBloc, SocketsVoiceState>(
            builder: (context, state) => Text(
              state.joinCreateRoomEntitie.roomName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          actions: const [
            InComingMessagesAppBarIcon(),
            ShowRecordingPathWidget(),
            CopyRoomIdWidgetIfPrivate(),
            LeaveRoomButtonWidget(),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        body: const TabBarView(
          children: [
            LiveVoiceRoomWidget(),
            RoomChatWidget(),
          ],
        ),
      ),
    );
  }
}
