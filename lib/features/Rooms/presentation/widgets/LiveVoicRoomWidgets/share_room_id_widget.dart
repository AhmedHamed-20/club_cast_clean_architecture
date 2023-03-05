import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CopyRoomIdWidgetIfPrivate extends StatelessWidget {
  const CopyRoomIdWidgetIfPrivate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketsVoiceBloc, SocketsVoiceState>(
        builder: (context, state) {
      if (state.isCreateRoom &&
          state.joinCreateRoomEntitie.roomType == 'private') {
        return Defaults.defaultTextButton(
          onPressed: () async {
            await Clipboard.setData(
              ClipboardData(
                text: state.joinCreateRoomEntitie.roomId,
              ),
            );

            if (await Clipboard.hasStrings()) {
              flutterToast(
                  msg: 'Room Id Copied',
                  backgroundColor: AppColors.toastSuccess,
                  textColor: AppColors.white);
            }
          },
          child: const Icon(Icons.copy),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
