import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/ValidationHelper/validation_helper.dart';
import '../../../../../core/constants/text_editing_controllers.dart';
import '../../../../../core/widgets/defaults.dart';

final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

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
    return Form(
      key: signUpFormKey,
      child: Column(
        children: [
          Defaults.defaultTextFormField(
            context: context,
            validator: (value) => ValidationHelper.validateName(value: value),
            controller: TextEditingControllers.signUpNameController,
            labelText: AppStrings.name.tr(),
            labelStyle: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: AppHeight.h10,
          ),
          Defaults.defaultTextFormField(
            validator: (value) => ValidationHelper.validateEmail(value: value),
            context: context,
            controller: TextEditingControllers.signUpEmailController,
            labelText: AppStrings.email.tr(),
            labelStyle: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: AppHeight.h10,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) => Defaults.defaultTextFormField(
              context: context,
              validator: (value) =>
                  ValidationHelper.validatePassword(value: value),
              controller: TextEditingControllers.signUpPasswordController,
              labelText: AppStrings.password.tr(),
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
                  authBloc.add(
                      SignupPasswordHideEvent(!state.isSignupPasswordHide));
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
              controller:
                  TextEditingControllers.signUpPasswordConfirmController,
              labelText: AppStrings.confirmPassword.tr(),
              validator: (value) => ValidationHelper.validatePassowrdConfirm(
                  confirmPassword: value,
                  password:
                      TextEditingControllers.signUpPasswordController.text),
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
                  authBloc.add(
                      SignupPasswordHideEvent(!state.isSignupPasswordHide));
                },
              ),
            ),
          ),
        ],
      ),
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
