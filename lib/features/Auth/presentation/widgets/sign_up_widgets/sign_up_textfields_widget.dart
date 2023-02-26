import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Column(
      children: [
        Defaults.defaultTextFormField(
          context: context,
          controller: TextEditingControllers.signUpNameController,
          labelText: 'Name',
          labelStyle: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: AppHeight.h10,
        ),
        Defaults.defaultTextFormField(
          context: context,
          controller: TextEditingControllers.signUpEmailController,
          labelText: 'Email',
          labelStyle: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: AppHeight.h10,
        ),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) => Defaults.defaultTextFormField(
            context: context,
            controller: TextEditingControllers.signUpPasswordController,
            labelText: 'Password',
            labelStyle: Theme.of(context).textTheme.titleMedium,
            obscureText: state.isSignupPasswordHide,
            suffixIcon: IconButton(
              icon: Icon(
                state.isSignupPasswordHide
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                authBloc
                    .add(SignupPasswordHideEvent(!state.isSignupPasswordHide));
              },
            ),
          ),
        ),
        SizedBox(
          height: AppHeight.h10,
        ),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) => Defaults.defaultTextFormField(
            context: context,
            controller: TextEditingControllers.signUpPasswordConfirmController,
            labelText: 'Password Confirm',
            labelStyle: Theme.of(context).textTheme.titleMedium,
            obscureText: state.isSignupPasswordHide,
            suffixIcon: IconButton(
              icon: Icon(
                state.isSignupPasswordHide
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                authBloc
                    .add(SignupPasswordHideEvent(!state.isSignupPasswordHide));
              },
            ),
          ),
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
