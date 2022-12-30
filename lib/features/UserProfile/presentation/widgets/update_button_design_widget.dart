import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateButtonDesignWidget extends StatelessWidget {
  const UpdateButtonDesignWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserprofileBloc>(context);
    return Defaults.defaultButton(
        onPressed: () {
          userProfileBloc.add(UserDataUpdateEvent(
              accessToken: ConstVar.accessToken,
              name:
                  TextEditingControllers.updateMyDataNameController.text.trim(),
              email: TextEditingControllers.updateMyDataEmailController.text
                  .trim(),
              bio: TextEditingControllers.updateMyDataBioController.text
                  .trim()));
        },
        context: context,
        text: 'Confirm ');
  }
}
