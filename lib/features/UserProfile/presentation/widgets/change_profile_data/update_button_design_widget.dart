import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/change_profile_data/update_my_data_text_fields.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/AppStrings/app_strings.dart';

class UpdateButtonDesignWidget extends StatelessWidget {
  const UpdateButtonDesignWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    return Defaults.defaultButton(
        onPressed: () {
          if (updateMyDataFormKey.currentState!.validate()) {
            userProfileBloc.add(UserDataUpdateEvent(
                accessToken: ConstVar.accessToken,
                name: TextEditingControllers.updateMyDataNameController.text
                    .trim(),
                email: TextEditingControllers.updateMyDataEmailController.text
                    .trim(),
                bio: TextEditingControllers.updateMyDataBioController.text
                    .trim()));
          }
        },
        context: context,
        text: AppStrings.confirm.tr());
  }
}
