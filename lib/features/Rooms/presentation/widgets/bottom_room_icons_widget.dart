import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class BottomRoomIconsWidget extends StatelessWidget {
  const BottomRoomIconsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: AppRadius.r22,
          backgroundColor: Theme.of(context).colorScheme.background,
          child: const Icon(Icons.mic),
        ),
      ],
    );
  }
}
