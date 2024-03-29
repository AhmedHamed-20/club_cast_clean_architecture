import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/chat_room_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import 'chat_widget.dart';

class RoomChatWidget extends StatelessWidget {
  const RoomChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(
          children: [
            Text(
              AppStrings.roomChat.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const ChatWidget(),
            const ChatRoomTextField(),
          ],
        ),
      ),
    );
  }
}
