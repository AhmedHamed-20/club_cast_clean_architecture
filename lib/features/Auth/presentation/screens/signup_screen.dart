import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/sign_up_button_widget.dart';
import '../widgets/sign_up_textfields_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          'SignUp',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Column(
            children: [
              const SizedBox(
                height: AppHeight.h10,
              ),
              Image.asset('assets/images/signPhoto.png'),
              const SizedBox(
                height: AppHeight.h10,
              ),
              const SignUpTextFieldsWidget(),
              const SizedBox(
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
