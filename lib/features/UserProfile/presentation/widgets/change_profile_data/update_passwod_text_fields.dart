import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/change_profile_data/update_passwod_button_widget.dart';
import 'package:flutter/material.dart';

class UpdatePasswordTextFields extends StatelessWidget {
  const UpdatePasswordTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.defaultTextFormField(
          context: context,
          controller: TextEditingControllers.updateMyDataPasswordController,
          labelText: 'Old Password',
          labelStyle: Theme.of(context).textTheme.titleSmall,
          prefixIcon: Icon(
            Icons.password,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        Defaults.defaultTextFormField(
          context: context,
          labelStyle: Theme.of(context).textTheme.titleSmall,
          controller: TextEditingControllers.updateMyDataNewPasswordController,
          labelText: 'New Password',
          prefixIcon: Icon(
            Icons.password,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        Defaults.defaultTextFormField(
          context: context,
          labelStyle: Theme.of(context).textTheme.titleSmall,
          controller:
              TextEditingControllers.updateMyDataPasswordConfirmController,
          labelText: 'Confirm Password',
          prefixIcon: Icon(
            Icons.password,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        const SizedBox(
          height: AppHeight.h20,
        ),
        const UpdatePasswodButtonWidget(),
      ],
    );
  }
}
