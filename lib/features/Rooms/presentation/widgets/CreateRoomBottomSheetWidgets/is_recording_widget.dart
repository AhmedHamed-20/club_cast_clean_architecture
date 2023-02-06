import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';

bool isRecordingRoom = false;

class IsRecordingWidget extends StatelessWidget {
  const IsRecordingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isRecordingRoom
              ? Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recording',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: AppHeight.h6,
                      ),
                      Text(
                        'The room will be recorded and saved to your storage',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Not Recording',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: AppHeight.h6,
                      ),
                      Text(
                        'The room will not be recorded',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary),
                      ),
                    ],
                  ),
                ),
          Switch(
              value: isRecordingRoom,
              onChanged: (value) {
                setState(() {
                  isRecordingRoom = value;
                });
              }),
        ],
      ),
    );
  }
}
