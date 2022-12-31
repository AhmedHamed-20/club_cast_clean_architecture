import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/screens/create_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/userprofile_bloc.dart';

class CreateEventButtonWidgetDesign extends StatelessWidget {
  const CreateEventButtonWidgetDesign({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    return Defaults.defaultButton(
      onPressed: () {
        if (eventDate != null) {
          userProfileBloc.add(EventCreateEvent(
              accessToken: ConstVar.accessToken,
              eventName: TextEditingControllers.createEventTitleController.text,
              eventDescription:
                  TextEditingControllers.createEventDescriptionController.text,
              eventDate: eventDate!));
        } else if (eventDate == null) {
          flutterToast(
              msg: 'Please select a date',
              backgroundColor: AppColors.toastError,
              textColor: AppColors.white);
        }
      },
      context: context,
      text: 'Create Event',
    );
  }
}
