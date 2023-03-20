import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_events_data_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/ValidationHelper/validation_helper.dart';
import '../../../../../core/constants/AppStrings/app_strings.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/text_editing_controllers.dart';
import '../../../../../core/widgets/defaults.dart';
import 'edit_date_edit_event_screen_widget.dart';

final GlobalKey<FormState> editEventFormKey = GlobalKey<FormState>();

class EditEventTextFieldsWidget extends StatefulWidget {
  const EditEventTextFieldsWidget({super.key, required this.myEventEntitie});
  final MyEventsDataEntity myEventEntitie;

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
    return Form(
      key: editEventFormKey,
      child: Column(
        children: [
          Defaults.defaultTextFormField(
            labelStyle: Theme.of(context).textTheme.titleSmall,
            prefixIcon: Icon(
              Icons.title,
              color: Theme.of(context).iconTheme.color,
            ),
            context: context,
            labelText: AppStrings.title.tr(),
            validator: (value) => ValidationHelper.validateName(
                value: value, name: AppStrings.title.tr()),
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
              validator: (value) => ValidationHelper.validateName(
                  value: value, name: AppStrings.eventDescription.tr()),
              labelText: AppStrings.eventDescription.tr(),
              controller: TextEditingControllers.editEventDescriptionController,
            ),
          ),
        ],
      ),
    );
  }

  void initEventsControllers() {
    TextEditingControllers.editEventTitleController = TextEditingController();
    TextEditingControllers.editEventDescriptionController =
        TextEditingController();
    TextEditingControllers.editEventTitleController.text =
        widget.myEventEntitie.eventName;
    TextEditingControllers.editEventDescriptionController.text =
        widget.myEventEntitie.eventDescription;
  }

  disposeEventsControllers() {
    TextEditingControllers.editEventTitleController.dispose();
    TextEditingControllers.editEventDescriptionController.dispose();
  }
}
