import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/AppStrings/app_strings.dart';
import '../../../../../core/routes/app_route_names.dart';
import '../../../../../core/utl/utls.dart';
import 'login_button_design.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state.loginRequestStatus == LoginRequestStatus.cachedSuccess) {
        flutterToast(
          msg: AppStrings.welcome.tr(),
          backgroundColor: AppColors.toastSuccess,
          textColor: AppColors.white,
        );
        authBloc.add(AuthRequestStatusResset());
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutesNames.layoutScreen,
          (route) => false,
        );
      } else if (state.loginRequestStatus == LoginRequestStatus.error) {
        flutterToast(
          msg: state.errorMessage,
          backgroundColor: AppColors.toastError,
          textColor: AppColors.white,
        );
      }
    }, builder: (context, state) {
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
