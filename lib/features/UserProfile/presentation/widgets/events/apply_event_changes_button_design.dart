import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_events_data_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/events/edit_date_edit_event_screen_widget.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/events/edit_event_text_fields_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/MyEventsBloc/my_events_bloc.dart';

class ApplyEventChangesButtonDesign extends StatelessWidget {
  const ApplyEventChangesButtonDesign(
      {super.key, required this.myEventEntitie});
  final MyEventsDataEntitie myEventEntitie;
  @override
  Widget build(BuildContext context) {
    final myEventsBloc = BlocProvider.of<MyEventsBloc>(context);
    return Defaults.defaultButton(
      onPressed: () {
        if (editEventFormKey.currentState!.validate()) {
          myEventsBloc.add(EventUpdateDataEvent(
              accessToken: ConstVar.accessToken,
              eventId: myEventEntitie.eventId,
              eventName: TextEditingControllers.editEventTitleController.text,
              eventDescription:
                  TextEditingControllers.editEventDescriptionController.text,
              eventDate: newEventDate != ''
                  ? DateTime.parse(newEventDate).toString()
                  : myEventEntitie.eventDate));
        }
      },
      context: context,
      text: AppStrings.applyChanges.tr(),
    );
  }
}
