import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/change_profile_data/update_passwod_text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordButtonDesignWidget extends StatelessWidget {
  const UpdatePasswordButtonDesignWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    return Defaults.defaultButton(
        onPressed: () {
          if (updatePasswordFormKey.currentState!.validate()) {
            userProfileBloc.add(PasswordUpdateEvent(
                accessToken: ConstVar.accessToken,
                newPassword: TextEditingControllers
                    .updateMyDataNewPasswordController.text,
                currentPassword:
                    TextEditingControllers.updateMyDataPasswordController.text,
                confirmPassword: TextEditingControllers
                    .updateMyDataPasswordConfirmController.text));
          }
        },
        context: context,
        text: 'Update Password ');
  }
}
