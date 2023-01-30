import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/text_editing_controllers.dart';
import '../../../../../core/widgets/defaults.dart';

class EditEventTextFieldsWidget extends StatefulWidget {
  const EditEventTextFieldsWidget({super.key});

  @override
  State<EditEventTextFieldsWidget> createState() =>
      _EditEventTextFieldsWidgetState();
}

class _EditEventTextFieldsWidgetState extends State<EditEventTextFieldsWidget> {
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
          labelStyle: Theme.of(context).textTheme.titleSmall,
          prefixIcon: Icon(
            Icons.title,
            color: Theme.of(context).iconTheme.color,
          ),
          context: context,
          labelText: 'Title',
          controller: TextEditingControllers.editEventTitleController,
        ),
        SizedBox(
          height: AppHeight.h10,
        ),
        SizedBox(
          height: MediaQueryOfMethods.getAppHeight(context) * 0.2,
          child: Defaults.defaultTextFormField(
            maxLine: 4,
            labelStyle: Theme.of(context).textTheme.titleSmall,
            prefixIcon: Icon(
              Icons.title,
              color: Theme.of(context).iconTheme.color,
            ),
            context: context,
            labelText: 'Description',
            controller: TextEditingControllers.editEventDescriptionController,
          ),
        ),
      ],
    );
  }

  void initControllers() {
    TextEditingControllers.editEventTitleController = TextEditingController();
    TextEditingControllers.editEventDescriptionController =
        TextEditingController();
  }

  void disposeControllers() {
    TextEditingControllers.editEventTitleController.dispose();
    TextEditingControllers.editEventDescriptionController.dispose();
  }
}
