import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/LiveVoicRoomWidgets/rooms_audience_brodacsters_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import 'live_voice_room_floating_action_button_widget.dart';

class LiveVoiceRoomWidget extends StatelessWidget {
  const LiveVoiceRoomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparentColor,
      floatingActionButton: const RoomVoiceFloatingActionButtonWidget(),
      body: Card(
        color: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.r22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            RoomsAudienceBrodcastersWidget(),
          ],
        ),
      ),
    );
  }
}
