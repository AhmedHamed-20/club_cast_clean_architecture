import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/text_editing_controllers.dart';
import '../../../../../core/widgets/defaults.dart';

class SignUpTextFieldsWidget extends StatefulWidget {
  const SignUpTextFieldsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpTextFieldsWidget> createState() => _SignUpTextFieldsWidgetState();
}

class _SignUpTextFieldsWidgetState extends State<SignUpTextFieldsWidget> {
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
    return Column(
      children: [
        Defaults.defaultTextFormField(
          context: context,
          controller: TextEditingControllers.signUpNameController,
          labelText: 'Name',
          labelStyle: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        Defaults.defaultTextFormField(
          context: context,
          controller: TextEditingControllers.signUpEmailController,
          labelText: 'Email',
          labelStyle: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        Defaults.defaultTextFormField(
          context: context,
          controller: TextEditingControllers.signUpPasswordController,
          labelText: 'Password',
          labelStyle: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        Defaults.defaultTextFormField(
          context: context,
          controller: TextEditingControllers.signUpPasswordConfirmController,
          labelText: 'Password Confirm',
          labelStyle: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  void initControllers() {
    TextEditingControllers.signUpNameController = TextEditingController();
    TextEditingControllers.signUpEmailController = TextEditingController();
    TextEditingControllers.signUpPasswordController = TextEditingController();
    TextEditingControllers.signUpPasswordConfirmController =
        TextEditingController();
  }

  void disposeControllers() {
    TextEditingControllers.signUpNameController.dispose();
    TextEditingControllers.signUpEmailController.dispose();
    TextEditingControllers.signUpPasswordController.dispose();
    TextEditingControllers.signUpPasswordConfirmController.dispose();
  }
}
