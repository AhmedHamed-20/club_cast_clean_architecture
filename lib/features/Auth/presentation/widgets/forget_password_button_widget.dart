import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/widgets/forget_password_button_design_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';

class ForgetPasswordButtonWidget extends StatelessWidget {
  const ForgetPasswordButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      switch (state.forgetPasswordRequestStatus) {
        case ForgetPasswordRequestStatus.idle:
          return const ForgetPasswordButtonDesignWidget();
        case ForgetPasswordRequestStatus.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case ForgetPasswordRequestStatus.success:
          return const ForgetPasswordButtonDesignWidget();
        case ForgetPasswordRequestStatus.error:
          return const ForgetPasswordButtonDesignWidget();
      }
    });
  }
}
