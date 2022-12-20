import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:flutter/material.dart';

import '../widgets/forget_password_button_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          centerTitle: true,
          title: Text(
            'Forget Password',
            style: Theme.of(context).textTheme.titleLarge,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Column(
            children: [
              Image.asset('assets/images/forget_password.png'),
              const SizedBox(
                height: AppHeight.h10,
              ),
              Defaults.defaultTextFormField(
                  context: context,
                  controller: TextEditingControllers.forgetPasswordController,
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  labelText: 'Email'),
              const SizedBox(
                height: AppHeight.h10,
              ),
              const ForgetPasswordButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
