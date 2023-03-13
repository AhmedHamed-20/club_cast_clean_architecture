import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/ValidationHelper/validation_helper.dart';
import '../../../../../core/constants/AppStrings/app_strings.dart';
import '../../../../../core/constants/text_editing_controllers.dart';
import '../../../../../core/widgets/defaults.dart';

final GlobalKey<FormState> createRoomFormKey = GlobalKey<FormState>();

class RoomNameTextFieldWidget extends StatefulWidget {
  const RoomNameTextFieldWidget({super.key});

  @override
  State<RoomNameTextFieldWidget> createState() =>
      _RoomNameTextFieldWidgetState();
}

class _RoomNameTextFieldWidgetState extends State<RoomNameTextFieldWidget> {
  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: createRoomFormKey,
      child: Defaults.defaultTextFormField(
        context: context,
        validator: (value) => ValidationHelper.validateRoomName(
          value: value,
        ),
        controller: TextEditingControllers.createRoomNameController,
        labelText: AppStrings.roomName.tr(),
      ),
    );
  }

  void initControllers() {
    TextEditingControllers.createRoomNameController = TextEditingController();
  }

  void disposeControllers() {
    TextEditingControllers.createRoomNameController.dispose();
  }
}
