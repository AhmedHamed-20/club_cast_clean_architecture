import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/text_editing_controllers.dart';
import '../../../../../core/widgets/defaults.dart';
import '../../../domain/entities/my_event_entitie.dart';
import 'edit_date_edit_event_screen_widget.dart';

class EditEventTextFieldsWidget extends StatefulWidget {
  const EditEventTextFieldsWidget({super.key, required this.myEventEntitie});
  final MyEventEntitie myEventEntitie;

  @override
  State<EditEventTextFieldsWidget> createState() =>
      _EditEventTextFieldsWidgetState();
}

class _EditEventTextFieldsWidgetState extends State<EditEventTextFieldsWidget> {
  @override
  void initState() {
    super.initState();
    initEventsControllers();
  }

  @override
  void dispose() {
    disposeEventsControllers();
    newEventDate = '';
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

  void initEventsControllers() {
    TextEditingControllers.editEventTitleController = TextEditingController();
    TextEditingControllers.editEventDescriptionController =
        TextEditingController();
    TextEditingControllers.editEventTitleController.text =
        widget.myEventEntitie.eventName;
    print(TextEditingControllers.editEventTitleController.text);
    TextEditingControllers.editEventDescriptionController.text =
        widget.myEventEntitie.eventDescription;
  }

  disposeEventsControllers() {
    TextEditingControllers.editEventTitleController.dispose();
    TextEditingControllers.editEventDescriptionController.dispose();
  }
}
