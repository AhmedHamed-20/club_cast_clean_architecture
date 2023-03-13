import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_events_data_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/MyEventsBloc/my_events_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/events/apply_event_changes_button_widget.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/events/edit_date_edit_event_screen_widget.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/events/edit_event_text_fields_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/events/delete_event_alert_dialog_widget.dart';

class EditEventScreen extends StatelessWidget {
  const EditEventScreen({super.key, required this.myEventEntitie});
  final MyEventsDataEntitie myEventEntitie;

  @override
  Widget build(BuildContext context) {
    final myEventsBloc = BlocProvider.of<MyEventsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          AppStrings.editEvent.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: myEventsBloc,
                      child: DeleteEventAlertDialogWidget(
                        eventId: myEventEntitie.eventId,
                      ),
                    );
                  });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Column(
            children: [
              EditEventTextFieldsWidget(myEventEntitie: myEventEntitie),
              SizedBox(
                height: AppHeight.h10,
              ),
              EditDateEditEventScreenWidget(
                eventDate: myEventEntitie.eventDate,
              ),
              SizedBox(
                height: AppHeight.h20,
              ),
              ApplyChangesButtonWidget(
                myEventEntitie: myEventEntitie,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
