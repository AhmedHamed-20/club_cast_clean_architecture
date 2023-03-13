import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/change_profile_data/update_image_button_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utl/utls.dart';

class UpdateUserImageButtonWidget extends StatelessWidget {
  const UpdateUserImageButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
      if (state.updateUserPhotoRequestStatus ==
          UpdateUserDataRequestStatus.success) {
        BlocProvider.of<LayoutBloc>(context)
            .add(ActiveUserDataGetEvent(ConstVar.accessToken));
        flutterToast(
            msg: AppStrings.updatedSuccessfully.tr(),
            backgroundColor: AppColors.toastSuccess,
            textColor: AppColors.white);
        Navigator.of(context).pop();
      } else if (state.updateUserPhotoRequestStatus ==
          UpdateUserDataRequestStatus.error) {
        flutterToast(
            msg: state.errorMessage,
            backgroundColor: AppColors.toastError,
            textColor: AppColors.white);
        Navigator.of(context).pop();
      }
    }, builder: (context, state) {
      switch (state.updateUserPhotoRequestStatus) {
        case UpdateUserDataRequestStatus.idle:
          return UpdateImageButtonDesign(
            photoPath: state.pickedUserProfileImageFilePath,
          );
        case UpdateUserDataRequestStatus.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case UpdateUserDataRequestStatus.success:
          return UpdateImageButtonDesign(
            photoPath: state.pickedUserProfileImageFilePath,
          );
        case UpdateUserDataRequestStatus.error:
          return UpdateImageButtonDesign(
            photoPath: state.pickedUserProfileImageFilePath,
          );
      }
    });
  }
}
