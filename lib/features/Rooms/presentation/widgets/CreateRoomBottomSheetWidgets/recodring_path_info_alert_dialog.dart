import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RecordingPathAlertDialogInfo extends StatelessWidget {
  const RecordingPathAlertDialogInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppStrings.recordingPath.tr(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        '${AppStrings.roomWillBeSavedAt.tr()} Android > data > com.example.club_cast > room name',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            AppStrings.ok.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
