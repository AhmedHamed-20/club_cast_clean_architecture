import 'dart:io';

import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/change_profile_data/update_user_image_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../bloc/userprofile_bloc.dart';

class ChangePhotoAlertDialogWidget extends StatelessWidget {
  const ChangePhotoAlertDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    return AlertDialog(
      scrollable: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(
        AppStrings.changeProfileImage.tr(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          return Column(
            children: [
              Text(
                AppStrings.doYouWantToChangeYourProfileImage.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: AppHeight.h10,
              ),
              state.pickedUserProfileImageFilePath != ''
                  ? CircleAvatar(
                      radius: AppRadius.r70,
                      backgroundImage: FileImage(
                        File(
                          state.pickedUserProfileImageFilePath,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
      actions: [
        BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              state.updateUserPhotoRequestStatus ==
                      UpdateUserDataRequestStatus.loading
                  ? const SizedBox.shrink()
                  : TextButton(
                      onPressed: () {
                        userProfileBloc.add(
                          const PickImageEvent(),
                        );
                      },
                      child: Text(
                        state.pickedUserProfileImageFilePath != ''
                            ? AppStrings.pickAnotherImage.tr()
                            : AppStrings.pickAnImage.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
              state.pickedUserProfileImageFilePath != ''
                  ? const Flexible(child: UpdateUserImageButtonWidget())
                  : const SizedBox.shrink(),
            ],
          );
        })
      ],
    );
  }
}
