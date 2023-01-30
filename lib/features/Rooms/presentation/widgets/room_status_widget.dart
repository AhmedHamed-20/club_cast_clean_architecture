import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';

bool isPublic = true;

class RoomStatusWidget extends StatelessWidget {
  const RoomStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isPublic
              ? Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Public',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: AppHeight.h6,
                      ),
                      Text(
                        'Anyone can join',
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
                        'Private',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: AppHeight.h6,
                      ),
                      Text(
                        'Only people with the code can join',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary),
                      ),
                    ],
                  ),
                ),
          Switch(
              value: isPublic,
              onChanged: (value) {
                setState(() {
                  isPublic = value;
                });
              }),
        ],
      ),
    );
  }
}
