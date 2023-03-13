import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/AppStrings/app_strings.dart';
import '../widgets/sign_up_widgets/sign_up_button_widget.dart';
import '../widgets/sign_up_widgets/sign_up_textfields_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          AppStrings.signUp.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Column(
            children: [
              SizedBox(
                height: AppHeight.h10,
              ),
              Image.asset(AssetsPath.signUpImage),
              SizedBox(
                height: AppHeight.h10,
              ),
              const SignUpTextFieldsWidget(),
              SizedBox(
                height: AppHeight.h10,
              ),
              const SignUpButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
