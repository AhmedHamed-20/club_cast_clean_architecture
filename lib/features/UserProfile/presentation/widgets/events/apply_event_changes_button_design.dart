import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_event_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/events/edit_date_edit_event_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/userprofile_bloc.dart';

class ApplyEventChangesButtonDesign extends StatelessWidget {
  const ApplyEventChangesButtonDesign(
      {super.key, required this.myEventEntitie});
  final MyEventEntitie myEventEntitie;
  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    return Defaults.defaultButton(
      onPressed: () {
        userProfileBloc.add(EventUpdateDataEvent(
            accessToken: ConstVar.accessToken,
            eventId: myEventEntitie.eventId,
            eventName: TextEditingControllers.editEventTitleController.text,
            eventDescription:
                TextEditingControllers.editEventDescriptionController.text,
            eventDate: newEventDate != ''
                ? DateTime.parse(newEventDate).toString()
                : myEventEntitie.eventDate));
      },
      context: context,
      text: 'Apply Changes',
    );
  }
}
