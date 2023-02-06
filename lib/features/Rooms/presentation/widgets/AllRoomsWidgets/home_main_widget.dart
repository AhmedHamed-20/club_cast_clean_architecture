import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';

import 'all_rooms_main_widget.dart';
import '../Events/my_following_events_widget.dart';

class HomeMainWidget extends StatelessWidget {
  const HomeMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            Text(
              'All Rooms',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppHeight.h10),
            const AllRoomsMainWidget(),
          ],
        ),
      ),
    );
  }
}
