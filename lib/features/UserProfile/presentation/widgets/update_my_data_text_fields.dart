import 'package:club_cast_clean_architecture/core/layout/domain/entities/user_data_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/text_editing_controllers.dart';
import '../../../../core/widgets/defaults.dart';

class UpdateMyDataTextFields extends StatelessWidget {
  const UpdateMyDataTextFields({super.key, required this.userDataEntitie});
  final UserDataEntitie userDataEntitie;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserprofileState>(
        builder: (context, state) {
      TextEditingControllers.updateMyDataBioController.text =
          state.updatedUserDataInfoEntitie?.bio ?? userDataEntitie.bio;
      TextEditingControllers.updateMyDataEmailController.text =
          state.updatedUserDataInfoEntitie?.email ?? userDataEntitie.email;
      TextEditingControllers.updateMyDataNameController.text =
          state.updatedUserDataInfoEntitie?.userName ??
              userDataEntitie.userName;
      return Column(
        children: [
          Defaults.defaultTextFormField(
              prefixIcon: Icon(
                Icons.text_fields,
                color: Theme.of(context).iconTheme.color,
              ),
              context: context,
              labelText: 'Name',
              labelStyle: Theme.of(context).textTheme.titleSmall,
              controller: TextEditingControllers.updateMyDataNameController),
          const SizedBox(
            height: AppHeight.h10,
          ),
          Defaults.defaultTextFormField(
              prefixIcon: Icon(
                Icons.email,
                color: Theme.of(context).iconTheme.color,
              ),
              context: context,
              labelStyle: Theme.of(context).textTheme.titleSmall,
              labelText: 'Email',
              controller: TextEditingControllers.updateMyDataEmailController),
          const SizedBox(
            height: AppHeight.h10,
          ),
          Defaults.defaultTextFormField(
              prefixIcon: Icon(
                Icons.text_fields,
                color: Theme.of(context).iconTheme.color,
              ),
              context: context,
              labelStyle: Theme.of(context).textTheme.titleSmall,
              labelText: 'Bio',
              controller: TextEditingControllers.updateMyDataBioController),
        ],
      );
    });
  }
}
