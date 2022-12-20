import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/services/service_locator.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/widgets/login_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/defaults.dart';
import '../widgets/dont_have_account_widget.dart';
import '../widgets/login_text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Column(
            children: [
              const SizedBox(
                height: AppHeight.h10,
              ),
              Image.asset('assets/images/login.png'),
              const SizedBox(
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
                    'Forget Password?',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppHeight.h10,
              ),
              const LoginButtonWidget(),
              const SizedBox(
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
