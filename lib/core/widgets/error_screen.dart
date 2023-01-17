import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/presentation/bloc/layout_bloc.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(
      {super.key, required this.message, this.onRetry, this.statusCode});
  final String message;
  final VoidCallback? onRetry;
  final int? statusCode;
  @override
  Widget build(BuildContext context) {
    return BlocListener<LayoutBloc, LayoutState>(
      listener: (context, state) {
        if (state.logoutRequestStatus == LogoutRequestStatus.logoutSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutesNames.loginScreen, (Route<dynamic> route) => false);
        } else if (state.logoutRequestStatus == LogoutRequestStatus.error) {
          flutterToast(
              msg: state.errorMessage,
              backgroundColor: AppColors.toastError,
              textColor: AppColors.white);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(
          children: [
            //    Image.asset('assets/images/error.gif'),
            const SizedBox(height: AppHeight.h10),
            Text(
              message,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppHeight.h20),
            statusCode != null && statusCode == 403 || statusCode == 401
                ? Defaults.defaultButton(
                    onPressed: () {
                      BlocProvider.of<LayoutBloc>(context).add(
                          const AccessTokenRemoveEvent(key: 'accessToken'));
                    },
                    context: context,
                    text: 'Go to login screen',
                  )
                : Defaults.defaultButton(
                    onPressed: onRetry!,
                    context: context,
                    text: 'Retry',
                  ),
          ],
        ),
      ),
    );
  }
}
