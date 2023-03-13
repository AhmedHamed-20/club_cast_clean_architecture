import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../../../../core/theme/app_theme.dart';

String newEventDate = '';

class EditDateEditEventScreenWidget extends StatelessWidget {
  const EditDateEditEventScreenWidget({super.key, required this.eventDate});
  final String eventDate;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          '${AppStrings.date.tr()}: ',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        StatefulBuilder(
          builder: (context, mySetState) => InkWell(
            onTap: () {
              DatePicker.showDateTimePicker(
                context,
                theme: AppTheme.datePickerTheme(context),
                minTime: DateTime.now(),
                currentTime: DateTime.parse(
                  newEventDate != '' ? newEventDate : eventDate,
                ),
                onConfirm: (time) {
                  mySetState(() {
                    newEventDate = time.toIso8601String().toString();
                  });
                },
              );
            },
            child: Text(
              DateTimeFormat.format(
                DateTime.parse(newEventDate != '' ? newEventDate : eventDate),
                format: 'd/m/Y H:i',
              ),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ],
    );
  }
}
