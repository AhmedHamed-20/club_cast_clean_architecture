import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:flutter/material.dart';

import '../widgets/forget_passwod_widgets/forget_password_button_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
              Image.asset(AssetsPath.forgetPasswordImage),
              SizedBox(
                height: AppHeight.h10,
              ),
              Defaults.defaultTextFormField(
                  context: context,
                  controller: TextEditingControllers.forgetPasswordController,
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  labelText: 'Email'),
              SizedBox(
                height: AppHeight.h10,
              ),
              const ForgetPasswordButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void initControllers() {
    TextEditingControllers.forgetPasswordController = TextEditingController();
  }

  void disposeControllers() {
    TextEditingControllers.forgetPasswordController.dispose();
  }
}
