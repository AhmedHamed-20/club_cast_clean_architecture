import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/AllRoomsWidgets/show_recoding_path_widget.dart';
import '../widgets/LiveVoicRoomWidgets/live_voice_room_widget.dart';
import '../widgets/LiveVoicRoomWidgets/room_name_leave_widget.dart';
import '../widgets/LiveVoicRoomWidgets/share_room_id_widget.dart';
import '../widgets/RoomChatWidgets/overly_widget.dart';
import '../widgets/RoomChatWidgets/room_chat_widget.dart';

OverlayEntry? overLayEntery;

PageController pageViewScrollController = PageController();
int currentPageIndex = 0;
final GlobalKey roomsWidgetKey = GlobalKey();

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state.inComingPrivateChatMessages.length == 1) {
          final overLay = Overlay.of(context);
          overLayEntery = OverlayEntry(
            builder: (context) {
              return OverLayWidget(
                overLayEntery: overLayEntery!,
              );
            },
          );
          overLay.insert(overLayEntery!);
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: roomsWidgetKey,
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(
                  text: 'Live Voice Room',
                ),
                Tab(
                  text: 'Room Chat',
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
      ),
    );
  }
}
