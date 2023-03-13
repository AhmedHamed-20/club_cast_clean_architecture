import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/routes/app_route_names.dart';
import '../../../../../core/utl/utls.dart';
import '../../bloc/sockets/voice/sockets_voice_bloc.dart';

class LeaveRoomAlertDialog extends StatelessWidget {
  const LeaveRoomAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocketsVoiceBloc, SocketsVoiceState>(
      listener: (context, state) {
        if (state.createRoomRequestStatus == CreateRoomRequestStatus.left ||
            state.joinRoomRequestStatus == JoinRoomRequestStatus.left) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutesNames.layoutScreen, (route) => false);
        }
      },
      child: AlertDialog(
        title: Text(
          AppStrings.leaveRoom.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: BlocBuilder<SocketsVoiceBloc, SocketsVoiceState>(
          builder: (context, state) => Text(
            state.isCreateRoom
                ? '${AppStrings.areYouSureYouWantToLeaveTheRoom.tr()} ${AppStrings.ifYouLeftTheRoomWillBeDeleted.tr()}'
                : AppStrings.areYouSureYouWantToLeaveTheRoom.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                AppStrings.cancel.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              )),
          TextButton(
              onPressed: () {
                BlocProvider.of<SocketsVoiceBloc>(context)
                    .add(const LeaveRoomEvent());
                BlocProvider.of<ChatBloc>(context)
                    .add(const LeaveChatRoomEvent());
                Navigator.of(context).pop();
              },
              child: Text(
                AppStrings.leave.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              )),
        ],
      ),
    );
  }
}
