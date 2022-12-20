import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/text_editing_controllers.dart';
import '../../../../core/widgets/defaults.dart';

class LoginTextFieldsWidget extends StatelessWidget {
  const LoginTextFieldsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.defaultTextFormField(
          context: context,
          controller: TextEditingControllers.loginEmailController,
          labelText: 'Email',
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        Defaults.defaultTextFormField(
          context: context,
          controller: TextEditingControllers.loginPasswordController,
          labelText: 'Password',
        ),
      ],
    );
  }
}
