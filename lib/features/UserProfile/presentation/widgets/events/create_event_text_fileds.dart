import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:flutter/material.dart';

class CreateEventsTextFields extends StatefulWidget {
  const CreateEventsTextFields({super.key});

  @override
  State<CreateEventsTextFields> createState() => _CreateEventsTextFieldsState();
}

class _CreateEventsTextFieldsState extends State<CreateEventsTextFields> {
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

  void initControllers() {
    TextEditingControllers.createEventTitleController = TextEditingController();
    TextEditingControllers.createEventDescriptionController =
        TextEditingController();
  }

  void disposeControllers() {
    TextEditingControllers.createEventTitleController.dispose();
    TextEditingControllers.createEventDescriptionController.dispose();
  }
}
