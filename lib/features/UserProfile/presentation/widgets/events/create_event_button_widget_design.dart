import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/screens/create_event_screen.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/events/create_event_text_fileds.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/MyEventsBloc/my_events_bloc.dart';

class CreateEventButtonWidgetDesign extends StatelessWidget {
  const CreateEventButtonWidgetDesign({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final myEventsBloc = BlocProvider.of<MyEventsBloc>(context);
    return Defaults.defaultButton(
      onPressed: () {
        if (createEventFormKey.currentState!.validate() && eventDate != null) {
          myEventsBloc.add(EventCreateEvent(
              accessToken: ConstVar.accessToken,
              eventName: TextEditingControllers.createEventTitleController.text,
              eventDescription:
                  TextEditingControllers.createEventDescriptionController.text,
              eventDate: eventDate!));
        } else if (eventDate == null) {
          flutterToast(
              msg: AppStrings.pleasePickADate.tr(),
              backgroundColor: AppColors.toastError,
              textColor: AppColors.white);
        }
      },
      context: context,
      text: AppStrings.createEvent.tr(),
    );
  }
}
