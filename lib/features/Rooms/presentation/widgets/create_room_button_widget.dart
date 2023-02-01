import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/core/routes/app_route_names.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/create_room_button_design.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/create_room_category.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/is_recording_widget.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/room_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/text_editing_controllers.dart';
import '../../../../core/utl/utls.dart';

class CreateRoomButtonWidget extends StatelessWidget {
  const CreateRoomButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocketsBloc, SocketsState>(listener: (context, state) {
      if (state.connectToSocketRequestStatus ==
              ConnectToSocketRequestStatus.success &&
          state.createRoomRequestStatus == CreateRoomRequestStatus.idle) {
        BlocProvider.of<SocketsBloc>(context).add(
          CreateRoomEvent(
            roomName: TextEditingControllers.createRoomNameController.text,
            category: roomCategoryValue,
            isRecording: isRecordingRoom,
            status: isPublic ? 'public' : 'private',
          ),
        );
      }

      if (state.createRoomRequestStatus == CreateRoomRequestStatus.success) {
        Navigator.of(context).pushNamed(AppRoutesNames.roomScreen,
            arguments: RoomScreenParams(BlocProvider.of<SocketsBloc>(context)));
      }
      if (state.createRoomRequestStatus == CreateRoomRequestStatus.left) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutesNames.layoutScreen, (route) => false);
      }
    }, builder: (context, state) {
      switch (state.createRoomRequestStatus) {
        case CreateRoomRequestStatus.idle:
          return const CreateRoomButtonDesign();
        case CreateRoomRequestStatus.loading:
          return const Center(child: CircularProgressIndicator());
        case CreateRoomRequestStatus.success:
          return const CreateRoomButtonDesign();
        case CreateRoomRequestStatus.left:
          return const CreateRoomButtonDesign();
        case CreateRoomRequestStatus.error:
          return const CreateRoomButtonDesign();
      }
    });
  }
}
