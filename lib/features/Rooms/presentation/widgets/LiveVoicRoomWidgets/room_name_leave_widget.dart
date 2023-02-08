import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/defaults.dart';
import '../../bloc/sockets/voice/sockets_voice_bloc.dart';
import 'leave_room_alert_dialog.dart';

class LeaveRoomButtonWidget extends StatelessWidget {
  const LeaveRoomButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final socketBloc = BlocProvider.of<SocketsBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
      child: Defaults.defaultTextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return BlocProvider.value(
                      value: socketBloc, child: const LeaveRoomAlertDialog());
                });
          },
          child: Text(
            'Leave',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          )),
    );
  }
}
