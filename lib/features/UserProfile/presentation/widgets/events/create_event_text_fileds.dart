import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:flutter/material.dart';

class CreateEventsTextFields extends StatelessWidget {
  const CreateEventsTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.defaultTextFormField(
          labelText: 'Event Name',
          context: context,
          labelStyle: Theme.of(context).textTheme.titleSmall,
          controller: TextEditingControllers.createEventTitleController,
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        SizedBox(
          height: MediaQueryOfMethods.getAppHeight(context) * 0.2,
          child: Defaults.defaultTextFormField(
            labelText: 'Event Description',
            maxLine: 4,
            context: context,
            labelStyle: Theme.of(context).textTheme.titleSmall,
            controller: TextEditingControllers.createEventDescriptionController,
          ),
        ),
      ],
    );
  }
}
