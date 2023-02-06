import 'package:flutter/material.dart';

import '../widgets/LiveVoicRoomWidgets/live_voice_room_widget.dart';
import '../widgets/RoomChatWidgets/room_chat_widget.dart';

PageController pageViewScrollController = PageController();
int currentPageIndex = 0;

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        //   floatingActionButton: FloatingActionButton(onPressed: () {}),
        //   resizeToAvoidBottomInset: false,
        appBar: AppBar(
          bottom: TabBar(
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
          title: Text(
            'Room',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        body: const TabBarView(
          children: [
            //height: MediaQueryOfMethods.getAppHeight(context) * 0.8,

            LiveVoiceRoomWidget(),
            RoomChatWidget(),
          ],
        ),
      ),
    );
  }
}
