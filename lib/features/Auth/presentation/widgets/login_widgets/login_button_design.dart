import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/widgets/login_widgets/login_text_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/defaults.dart';

class LoginButtonDesign extends StatelessWidget {
  const LoginButtonDesign({super.key});

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    return Defaults.defaultButton(
        onPressed: () {
          if (loginFormKey.currentState!.validate()) {
            authBloc.add(
              LoginEvent(
                TextEditingControllers.loginEmailController.text.trim(),
                TextEditingControllers.loginPasswordController.text,
              ),
            );
          }
        },
        context: context,
        text: AppStrings.login.tr());
  }
}
