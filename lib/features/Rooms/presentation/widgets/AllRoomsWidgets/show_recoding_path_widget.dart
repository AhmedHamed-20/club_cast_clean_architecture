import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../CreateRoomBottomSheetWidgets/recodring_path_info_alert_dialog.dart';

class ShowRecordingPathWidget extends StatelessWidget {
  const ShowRecordingPathWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketsVoiceBloc, SocketsVoiceState>(
      builder: (context, state) {
        if (state.isCreateRoom && state.joinCreateRoomEntitie.isRecording) {
          return IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const RecordingPathAlertDialogInfo());
              },
              icon: const Icon(Icons.info_outline));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
