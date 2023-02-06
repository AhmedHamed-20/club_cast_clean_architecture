import 'package:flutter/material.dart';

import '../../../../../core/constants/text_editing_controllers.dart';
import '../../../../../core/widgets/defaults.dart';

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
    return Defaults.defaultTextFormField(
      context: context,
      controller: TextEditingControllers.createRoomNameController,
      labelText: 'Room Name',
    );
  }

  void initControllers() {
    TextEditingControllers.createRoomNameController = TextEditingController();
  }

  void disposeControllers() {
    TextEditingControllers.createRoomNameController.dispose();
  }
}
