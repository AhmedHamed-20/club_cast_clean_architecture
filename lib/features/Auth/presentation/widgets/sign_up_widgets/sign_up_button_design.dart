import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpButtonDesign extends StatelessWidget {
  const SignUpButtonDesign({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Defaults.defaultButton(
      onPressed: () {
        authBloc.add(
          SignupEvent(
            TextEditingControllers.signUpEmailController.text,
            TextEditingControllers.signUpPasswordController.text,
            TextEditingControllers.signUpPasswordConfirmController.text,
            TextEditingControllers.signUpNameController.text,
          ),
        );
      },
      context: context,
      text: 'SignUp',
    );
  }
}
