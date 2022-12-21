import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/widgets/sign_up_button_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          switch (state.signUpRequestStatus) {
            case SignUpRequestStatus.idle:
              return const SignUpButtonDesign();
            case SignUpRequestStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case SignUpRequestStatus.signUpSuccess:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case SignUpRequestStatus.cachedSuccess:
              return const SignUpButtonDesign();
            case SignUpRequestStatus.error:
              return const SignUpButtonDesign();
          }
        },
        listener: (context, state) {});
  }
}
