import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/ValidationHelper/validation_helper.dart';

final GlobalKey<FormState> createEventFormKey = GlobalKey<FormState>();

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
    return Form(
      key: createEventFormKey,
      child: Column(
        children: [
          Defaults.defaultTextFormField(
            labelText: AppStrings.eventName.tr(),
            context: context,
            validator: (value) => ValidationHelper.validateName(
                value: value, name: AppStrings.eventName.tr()),
            labelStyle: Theme.of(context).textTheme.titleSmall,
            controller: TextEditingControllers.createEventTitleController,
          ),
          SizedBox(
            height: AppHeight.h10,
          ),
          SizedBox(
            height: MediaQueryOfMethods.getAppHeight(context) * 0.2,
            child: Defaults.defaultTextFormField(
              labelText: AppStrings.eventDescription.tr(),
              maxLine: 4,
              context: context,
              validator: (value) => ValidationHelper.validateName(
                  value: value, name: AppStrings.eventDescription.tr()),
              labelStyle: Theme.of(context).textTheme.titleSmall,
              controller:
                  TextEditingControllers.createEventDescriptionController,
            ),
          ),
        ],
      ),
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
