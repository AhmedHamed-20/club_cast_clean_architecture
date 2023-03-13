import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/change_profile_data/update_passwod_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/ValidationHelper/validation_helper.dart';

final GlobalKey<FormState> updatePasswordFormKey = GlobalKey<FormState>();

class UpdatePasswordTextFields extends StatefulWidget {
  const UpdatePasswordTextFields({super.key});

  @override
  State<UpdatePasswordTextFields> createState() =>
      _UpdatePasswordTextFieldsState();
}

class _UpdatePasswordTextFieldsState extends State<UpdatePasswordTextFields> {
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
    final userPrfoileBloc = BlocProvider.of<UserProfileBloc>(context);
    return Form(
      key: updatePasswordFormKey,
      child: Column(
        children: [
          BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) => Defaults.defaultTextFormField(
              context: context,
              controller: TextEditingControllers.updateMyDataPasswordController,
              labelText: AppStrings.password.tr(),
              validator: (value) => ValidationHelper.validatePassword(
                value: value,
              ),
              labelStyle: Theme.of(context).textTheme.titleSmall,
              prefixIcon: Icon(
                Icons.password,
                color: Theme.of(context).iconTheme.color,
              ),
              obscureText: state.isPasswordHide,
              suffixIcon: IconButton(
                icon: Icon(
                  state.isPasswordHide
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  userPrfoileBloc.add(PasswordHideEvent(!state.isPasswordHide));
                },
              ),
            ),
          ),
          SizedBox(
            height: AppHeight.h10,
          ),
          BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) => Defaults.defaultTextFormField(
              context: context,
              labelStyle: Theme.of(context).textTheme.titleSmall,
              controller:
                  TextEditingControllers.updateMyDataNewPasswordController,
              labelText: AppStrings.newPassword.tr(),
              validator: (value) => ValidationHelper.validatePassword(
                value: value,
              ),
              prefixIcon: Icon(
                Icons.password,
                color: Theme.of(context).iconTheme.color,
              ),
              obscureText: state.isPasswordHide,
              suffixIcon: IconButton(
                icon: Icon(
                  state.isPasswordHide
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  userPrfoileBloc.add(PasswordHideEvent(!state.isPasswordHide));
                },
              ),
            ),
          ),
          SizedBox(
            height: AppHeight.h10,
          ),
          BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) => Defaults.defaultTextFormField(
              context: context,
              labelStyle: Theme.of(context).textTheme.titleSmall,
              controller:
                  TextEditingControllers.updateMyDataPasswordConfirmController,
              labelText: AppStrings.confirmPassword.tr(),
              validator: (value) => ValidationHelper.validatePassowrdConfirm(
                confirmPassword: value,
                password: TextEditingControllers
                    .updateMyDataNewPasswordController.text,
              ),
              prefixIcon: Icon(
                Icons.password,
                color: Theme.of(context).iconTheme.color,
              ),
              obscureText: state.isPasswordHide,
              suffixIcon: IconButton(
                icon: Icon(
                  state.isPasswordHide
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  userPrfoileBloc.add(PasswordHideEvent(!state.isPasswordHide));
                },
              ),
            ),
          ),
          SizedBox(
            height: AppHeight.h20,
          ),
          const UpdatePasswodButtonWidget(),
        ],
      ),
    );
  }

  void initControllers() {
    TextEditingControllers.updateMyDataNewPasswordController =
        TextEditingController();
    TextEditingControllers.updateMyDataPasswordConfirmController =
        TextEditingController();
    TextEditingControllers.updateMyDataPasswordController =
        TextEditingController();
  }

  void disposeControllers() {
    TextEditingControllers.updateMyDataNewPasswordController.dispose();
    TextEditingControllers.updateMyDataPasswordConfirmController.dispose();
    TextEditingControllers.updateMyDataPasswordController.dispose();
  }
}
