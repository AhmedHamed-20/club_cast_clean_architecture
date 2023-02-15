import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/AllRoomsWidgets/all_rooms_main_widget.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/CreateRoomBottomSheetWidgets/room_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/text_editing_controllers.dart';
import 'create_room_button_widget.dart';
import 'create_room_category.dart';
import 'is_recording_widget.dart';

class CreateRoomButtonDesign extends StatelessWidget {
  const CreateRoomButtonDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Defaults.defaultButton(
      onPressed: () {
        if (isIAdminInRoom || isIuserInRoom) {
          flutterToast(
              msg: 'You are already in a room',
              backgroundColor: AppColors.toastWarning,
              textColor: AppColors.black);
        } else {
          BlocProvider.of<SocketsVoiceBloc>(context).add(ConnectToSocketEvent(
            accessToken: ConstVar.accessToken,
            isCreateRoom: true,
            createRoomParams: CreateRoomParams(
              roomName: TextEditingControllers.createRoomNameController.text,
              category: roomCategoryValue,
              isRecording: isRecordingRoom,
              status: isPublic ? 'public' : 'private',
            ),
          ));
        }
      },
      context: context,
      text: 'Create Room',
    );
  }
}