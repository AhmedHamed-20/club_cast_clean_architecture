import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/events/create_event_button_widget.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/events/create_event_text_fileds.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../../../core/theme/app_theme.dart';

String? eventDate;

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          AppStrings.createEvent.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Column(
            children: [
              const CreateEventsTextFields(),
              StatefulBuilder(builder: (context, setState) {
                return Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(
                        context,
                        locale: context.locale == ConstVar.enLocale
                            ? LocaleType.en
                            : LocaleType.ar,
                        theme: AppTheme.datePickerTheme(context),
                        minTime: DateTime.now(),
                        currentTime: DateTime.now(),
                        onConfirm: (time) {
                          setState(() => eventDate = time.toLocal().toString());
                        },
                      );
                    },
                    child: Text(
                      eventDate != null
                          ? DateTimeFormat.format(DateTime.parse(eventDate!),
                              format: 'd/M/Y H:i')
                          : AppStrings.pickADate.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                );
              }),
              SizedBox(height: AppHeight.h20),
              const CreateEventButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
