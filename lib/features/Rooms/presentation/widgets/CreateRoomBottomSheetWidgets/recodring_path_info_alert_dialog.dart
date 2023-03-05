import 'package:flutter/material.dart';

class RecordingPathAlertDialogInfo extends StatelessWidget {
  const RecordingPathAlertDialogInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Recording Path',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        'The room will be recorded and saved to Android > data > com.example.club_cast > room name',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Ok',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
