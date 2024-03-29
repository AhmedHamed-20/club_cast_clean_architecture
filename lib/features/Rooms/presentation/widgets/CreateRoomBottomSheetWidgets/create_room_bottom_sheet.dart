import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/CreateRoomBottomSheetWidgets/room_name_text_field_widget.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/CreateRoomBottomSheetWidgets/room_status_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/AppStrings/app_strings.dart';
import 'create_room_button_widget.dart';
import 'create_room_category.dart';
import 'is_recording_widget.dart';

class CreateRoomBottomSheet extends StatelessWidget {
  const CreateRoomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: AppPadding.p12,
        left: AppPadding.p12,
        right: AppPadding.p12,
      ),
      child: SizedBox(
        height: MediaQueryOfMethods.getAppHeight(context) * 0.6,
        child: Column(
          children: [
            Text(
              AppStrings.createRoom.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: AppHeight.h10,
            ),
            const RoomNameTextFieldWidget(),
            SizedBox(
              height: AppHeight.h46,
            ),
            const CreateRoomCategory(),
            SizedBox(
              height: AppHeight.h10,
            ),
            const RoomStatusWidget(),
            SizedBox(
              height: AppHeight.h10,
            ),
            const IsRecordingWidget(),
            SizedBox(
              height: AppHeight.h10,
            ),
            const CreateRoomButtonWidget(),
          ],
        ),
      ),
    );
  }
}
