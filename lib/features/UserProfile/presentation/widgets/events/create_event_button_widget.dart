import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/screens/create_event_screen.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/events/create_event_button_widget_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utl/utls.dart';

class CreateEventButtonWidget extends StatelessWidget {
  const CreateEventButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
      if (state.eventCreateRequestStatus == EventCreateRequestStatus.success) {
        flutterToast(
            msg: 'Event Updated',
            backgroundColor: AppColors.toastSuccess,
            textColor: AppColors.white);
        Navigator.of(context).pop();

        eventDate = null;
      } else if (state.eventCreateRequestStatus ==
          EventCreateRequestStatus.error) {
        flutterToast(
            msg: state.errorMessage,
            backgroundColor: AppColors.toastError,
            textColor: AppColors.white);
        Navigator.of(context).pop();
        eventDate = null;
      }
    }, builder: (context, state) {
      switch (state.eventCreateRequestStatus) {
        case EventCreateRequestStatus.idle:
          return const CreateEventButtonWidgetDesign();
        case EventCreateRequestStatus.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case EventCreateRequestStatus.success:
          return const CreateEventButtonWidgetDesign();
        case EventCreateRequestStatus.error:
          return const CreateEventButtonWidgetDesign();
      }
    });
  }
}
