import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/change_profile_data/change_password_bottom_sheet_widget.dart';
import '../widgets/change_profile_data/edit_user_image_widget.dart';
import '../widgets/change_profile_data/update_data_button_widget.dart';
import '../widgets/change_profile_data/update_my_data_text_fields.dart';

class EditUserProfileBasicDataScreen extends StatelessWidget {
  const EditUserProfileBasicDataScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          AppStrings.editProfile.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Column(
            children: [
              const EditUserScreenUserImageWidget(),
              SizedBox(
                height: AppHeight.h10,
              ),
              const UpdateMyDataTextFields(),
              SizedBox(
                height: AppHeight.h20,
              ),
              const UpdateDataButtonWidget(),
              SizedBox(
                height: AppHeight.h10,
              ),
              Defaults.defaultButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        isScrollControlled: true,
                        enableDrag: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppRadius.r22),
                            topRight: Radius.circular(
                              AppRadius.r22,
                            ),
                          ),
                        ),
                        builder: (context) {
                          return BlocProvider.value(
                              value: userProfileBloc,
                              child: const ChangePasswodBottomSheetWidget());
                        });
                  },
                  context: context,
                  text: AppStrings.updateYourPassword.tr())
            ],
          ),
        ),
      ),
    );
  }
}
