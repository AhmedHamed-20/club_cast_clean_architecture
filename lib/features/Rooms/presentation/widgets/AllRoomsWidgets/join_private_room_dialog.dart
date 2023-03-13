import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/AllRoomsWidgets/private_room_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'join_private_room_button_widget.dart';

class JoinPrivateRoomDialog extends StatelessWidget {
  const JoinPrivateRoomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppStrings.joinPrivateRoom.tr(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: const PrivateRoomTextField(),
      actions: const [
        JoinPrivateRoomButtonWidget(),
      ],
    );
  }
}
