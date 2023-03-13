import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/widgets/login_widgets/login_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/app_route_names.dart';
import '../../../../core/widgets/defaults.dart';
import '../widgets/forget_passwod_widgets/dont_have_account_widget.dart';
import '../widgets/login_widgets/login_text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.login.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: AppHeight.h10,
              ),
              Image.asset(AssetsPath.loginImage),
              SizedBox(
                height: AppHeight.h10,
              ),
              const LoginTextFieldsWidget(),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Defaults.defaultTextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutesNames.forgetPasswordScreen,
                    );
                  },
                  child: Text(
                    AppStrings.forgotPassword.tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: AppHeight.h10,
              ),
              const LoginButtonWidget(),
              SizedBox(
                height: AppHeight.h10,
              ),
              const DontHaveAccountWidget()
            ],
          ),
        ),
      ),
    );
  }
}
