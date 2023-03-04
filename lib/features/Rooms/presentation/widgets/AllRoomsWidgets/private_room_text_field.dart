import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:flutter/material.dart';

import '../../../../../core/ValidationHelper/validation_helper.dart';
import '../../../../../core/widgets/defaults.dart';

final GlobalKey<FormState> joinPrivateRoomFormKey = GlobalKey<FormState>();

class PrivateRoomTextField extends StatefulWidget {
  const PrivateRoomTextField({super.key});

  @override
  State<PrivateRoomTextField> createState() => _PrivateRoomTextFieldState();
}

class _PrivateRoomTextFieldState extends State<PrivateRoomTextField> {
  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: joinPrivateRoomFormKey,
      child: Defaults.defaultTextFormField(
        context: context,
        validator: (value) => ValidationHelper.privateRoomId(value: value),
        labelText: 'Room ID',
        controller: TextEditingControllers.joinPrivateRoomController,
      ),
    );
  }

  void initController() {
    TextEditingControllers.joinPrivateRoomController = TextEditingController();
  }

  void disposeController() {
    TextEditingControllers.joinPrivateRoomController.dispose();
  }
}
