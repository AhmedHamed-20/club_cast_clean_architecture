import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_room_icons_widget.dart';
import '../widgets/live_pop_arrow_widget.dart';
import '../widgets/room_name_leave_widget.dart';
import '../widgets/rooms_audience_brodacsters_widget.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQueryOfMethods.getAppHeight(context) * 0.87,
              child: Card(
                color: Theme.of(context).colorScheme.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    RoomNameAndLeaveWidget(),
                    LivePopArrowWidget(),
                    Expanded(
                      child: RoomsAudienceBrodcastersWidget(),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
                child: BottomRoomIconsWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
