import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:flutter/material.dart';

class CreateRoomButtonDesign extends StatelessWidget {
  const CreateRoomButtonDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Defaults.defaultButton(
        onPressed: () {}, context: context, text: 'Create Room');
  }
}
