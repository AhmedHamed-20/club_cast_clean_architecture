import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/events/apply_event_changes_button_widget.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/events/edit_event_text_fields_widget.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/events/edit_date_edit_event_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/my_event_entitie.dart';
import '../bloc/userprofile_bloc.dart';
import '../widgets/events/delete_event_alert_dialog_widget.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key, required this.myEventEntitie});
  final MyEventEntitie myEventEntitie;

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  @override
  void initState() {
    super.initState();
    TextEditingControllers.editEventTitleController.text =
        widget.myEventEntitie.eventName;
    TextEditingControllers.editEventDescriptionController.text =
        widget.myEventEntitie.eventDescription;
  }

  @override
  void dispose() {
    super.dispose();
    newEventDate = '';
  }

  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          'Edit Event',
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
                      value: userProfileBloc,
                      child: DeleteEventAlertDialogWidget(
                        eventId: widget.myEventEntitie.eventId,
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
              const EditEventTextFieldsWidget(),
              SizedBox(
                height: AppHeight.h10,
              ),
              EditDateEditEventScreenWidget(
                eventDate: widget.myEventEntitie.eventDate,
              ),
              SizedBox(
                height: AppHeight.h20,
              ),
              ApplyChangesButtonWidget(
                myEventEntitie: widget.myEventEntitie,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
