import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/text_editing_controllers.dart';
import '../../../../core/widgets/defaults.dart';

class EditEventTextFieldsWidget extends StatelessWidget {
  const EditEventTextFieldsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.defaultTextFormField(
          labelStyle: Theme.of(context).textTheme.titleSmall,
          prefixIcon: Icon(
            Icons.title,
            color: Theme.of(context).iconTheme.color,
          ),
          context: context,
          labelText: 'Title',
          controller: TextEditingControllers.editEventTitleController,
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        Defaults.defaultTextFormField(
          labelStyle: Theme.of(context).textTheme.titleSmall,
          prefixIcon: Icon(
            Icons.title,
            color: Theme.of(context).iconTheme.color,
          ),
          context: context,
          labelText: 'Description',
          controller: TextEditingControllers.editEventDescriptionController,
        ),
      ],
    );
  }
}
