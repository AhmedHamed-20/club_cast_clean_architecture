import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:flutter/material.dart';

class CreateRoomBottomSheet extends StatelessWidget {
  const CreateRoomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.defaultTextFormField(context: context),
      ],
    );
  }
}
