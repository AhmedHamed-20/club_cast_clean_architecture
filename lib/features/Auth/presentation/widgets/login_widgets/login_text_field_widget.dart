import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/text_editing_controllers.dart';
import '../../../../../core/widgets/defaults.dart';

class LoginTextFieldsWidget extends StatefulWidget {
  const LoginTextFieldsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginTextFieldsWidget> createState() => _LoginTextFieldsWidgetState();
}

class _LoginTextFieldsWidgetState extends State<LoginTextFieldsWidget> {
  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Column(
      children: [
        Defaults.defaultTextFormField(
          context: context,
          controller: TextEditingControllers.loginEmailController,
          labelText: 'Email',
          labelStyle: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: AppHeight.h10,
        ),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) => Defaults.defaultTextFormField(
            context: context,
            controller: TextEditingControllers.loginPasswordController,
            labelText: 'Password',
            labelStyle: Theme.of(context).textTheme.titleMedium,
            obscureText: state.isLoginPasswordHide,
            suffixIcon: IconButton(
              icon: Icon(
                state.isLoginPasswordHide
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                authBloc
                    .add(LoginPasswordHideEvent(!state.isLoginPasswordHide));
              },
            ),
          ),
        ),
      ],
    );
  }

  void initControllers() {
    TextEditingControllers.loginEmailController = TextEditingController();
    TextEditingControllers.loginPasswordController = TextEditingController();
  }

  void disposeControllers() {
    TextEditingControllers.loginEmailController.dispose();
    TextEditingControllers.loginPasswordController.dispose();
  }
}
