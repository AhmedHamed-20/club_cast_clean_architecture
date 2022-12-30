import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/update_passwod_button_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';

class UpdatePasswodButtonWidget extends StatelessWidget {
  const UpdatePasswodButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserprofileBloc, UserprofileState>(
        listener: (context, state) {
      if (state.updateUserDataRequestStatus ==
          UpdateUserDataRequestStatus.success) {
        flutterToast(
            msg: 'Updated Success',
            backgroundColor: AppColors.toastSuccess,
            textColor: AppColors.white);
      } else if (state.updateUserDataRequestStatus ==
          UpdateUserDataRequestStatus.error) {
        flutterToast(
            msg: state.errorMessage,
            backgroundColor: AppColors.toastError,
            textColor: AppColors.white);
      }
    }, builder: (context, state) {
      switch (state.updatePasswordRequestStatus) {
        case UpdateUserDataRequestStatus.idle:
          return const UpdatePasswordButtonDesignWidget();
        case UpdateUserDataRequestStatus.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case UpdateUserDataRequestStatus.success:
          return const UpdatePasswordButtonDesignWidget();
        case UpdateUserDataRequestStatus.error:
          return const UpdatePasswordButtonDesignWidget();
      }
    });
  }
}
