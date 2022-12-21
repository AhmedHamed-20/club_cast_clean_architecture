import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/widgets/sign_up_widgets/sign_up_button_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utl/utls.dart';

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
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
    }, listener: (context, state) {
      if (state.signUpRequestStatus == SignUpRequestStatus.cachedSuccess) {
        flutterToast(
          msg: 'Welcome',
          backgroundColor: AppColors.toastSuccess,
          textColor: AppColors.white,
        );
        authBloc.add(AuthRequestStatusResset());
        Navigator.of(context).pushNamed(AppRoutesNames.layoutScreen);
      } else if (state.signUpRequestStatus == SignUpRequestStatus.error) {
        flutterToast(
          msg: state.errorMessage,
          backgroundColor: AppColors.toastError,
          textColor: AppColors.white,
        );
      }
    });
  }
}
