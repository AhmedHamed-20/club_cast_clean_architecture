import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/change_profile_data/update_button_design_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utl/utls.dart';

class UpdateDataButtonWidget extends StatelessWidget {
  const UpdateDataButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserprofileState>(
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
      switch (state.updateUserDataRequestStatus) {
        case UpdateUserDataRequestStatus.idle:
          return const UpdateButtonDesignWidget();
        case UpdateUserDataRequestStatus.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case UpdateUserDataRequestStatus.success:
          return const UpdateButtonDesignWidget();
        case UpdateUserDataRequestStatus.error:
          return const UpdateButtonDesignWidget();
      }
    });
  }
}
