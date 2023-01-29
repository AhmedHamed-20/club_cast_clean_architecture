import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/text_editing_controllers.dart';
import '../../../../../core/widgets/defaults.dart';

class UpdateMyDataTextFields extends StatefulWidget {
  const UpdateMyDataTextFields({
    super.key,
  });

  @override
  State<UpdateMyDataTextFields> createState() => _UpdateMyDataTextFieldsState();
}

class _UpdateMyDataTextFieldsState extends State<UpdateMyDataTextFields> {
  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutBloc, LayoutState>(builder: (context, state) {
      TextEditingControllers.updateMyDataBioController.text =
          state.userDataEntitie!.bio;
      TextEditingControllers.updateMyDataEmailController.text =
          state.userDataEntitie!.email;
      TextEditingControllers.updateMyDataNameController.text =
          state.userDataEntitie!.userName;
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

  void initControllers() {
    TextEditingControllers.updateMyDataEmailController =
        TextEditingController();
    TextEditingControllers.updateMyDataNameController = TextEditingController();
    TextEditingControllers.updateMyDataBioController = TextEditingController();
  }

  void disposeControllers() {
    TextEditingControllers.updateMyDataEmailController.dispose();
    TextEditingControllers.updateMyDataNameController.dispose();
    TextEditingControllers.updateMyDataBioController.dispose();
  }
}
