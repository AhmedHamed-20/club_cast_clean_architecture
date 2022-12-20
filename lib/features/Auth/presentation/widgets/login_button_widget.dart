import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';
import 'login_button_design.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      switch (state.loginRequestStatus) {
        case LoginRequestStatus.idle:
          return const LoginButtonDesign();
        case LoginRequestStatus.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case LoginRequestStatus.loginSuccess:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case LoginRequestStatus.cachedSuccess:
          return const LoginButtonDesign();
        case LoginRequestStatus.error:
          return const LoginButtonDesign();
      }
    });
  }
}
