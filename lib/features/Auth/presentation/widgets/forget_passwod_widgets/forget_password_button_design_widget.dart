import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/defaults.dart';
import '../../screens/forget_password_screen.dart';

class ForgetPasswordButtonDesignWidget extends StatelessWidget {
  const ForgetPasswordButtonDesignWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    return Defaults.defaultButton(
      onPressed: () {
        if (forgetPasswordFormKey.currentState!.validate()) {
          authBloc.add(
            ForgetPasswordEvent(
              TextEditingControllers.forgetPasswordController.text.trim(),
            ),
          );
        }
      },
      context: context,
      text: AppStrings.sendPasswordResetLink.tr(),
    );
  }
}
