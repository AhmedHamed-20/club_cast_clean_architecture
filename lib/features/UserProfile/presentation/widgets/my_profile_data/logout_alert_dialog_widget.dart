import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/layout/presentation/bloc/layout_bloc.dart';
import '../../../../../core/routes/app_route_names.dart';
import '../../../../../core/utl/utls.dart';

class LogoutAlertDialogWidget extends StatelessWidget {
  const LogoutAlertDialogWidget({
    Key? key,
  }) : super(key: key);

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
      child: AlertDialog(
        title: Text(
          'Logout',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text('Are you sure you want to logout?',
            style: Theme.of(context).textTheme.titleMedium),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'No',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          BlocBuilder<LayoutBloc, LayoutState>(
            builder: (context, state) => TextButton(
              onPressed: () {
                if (state.layoutBottomSheetStatus.index == 0) {
                  BlocProvider.of<LayoutBloc>(context)
                      .add(const AccessTokenRemoveEvent(key: 'accessToken'));
                } else {
                  flutterToast(
                    msg:
                        'Your are listening to a podcast or in a room now , please stop it first',
                    backgroundColor: AppColors.toastWarning,
                    textColor: AppColors.black,
                  );
                }
              },
              child:
                  Text('Yes', style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
        ],
      ),
    );
  }
}
