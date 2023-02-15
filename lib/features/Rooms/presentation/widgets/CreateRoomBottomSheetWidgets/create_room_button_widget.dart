import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/routes/app_route_names.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/CreateRoomBottomSheetWidgets/create_room_button_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utl/utls.dart';

bool isIAdminInRoom = false;

class CreateRoomButtonWidget extends StatelessWidget {
  const CreateRoomButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocketsVoiceBloc, SocketsVoiceState>(
        listener: (context, state) {
      if (state.connectToSocketRequestStatus ==
              ConnectToSocketRequestStatus.success &&
          state.createRoomRequestStatus == CreateRoomRequestStatus.idle) {
        isIAdminInRoom = false;
        flutterToast(
            msg: 'Creating Room...',
            backgroundColor: AppColors.toastWarning,
            textColor: AppColors.black);
      }
      if (state.createRoomRequestStatus == CreateRoomRequestStatus.success &&
          isIAdminInRoom == false) {
        BlocProvider.of<ChatBloc>(context).add(const ListenOnChatEventsEvent());
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(
          AppRoutesNames.roomScreen,
        );
        //to prevent always pushing to room screen when state changes
        isIAdminInRoom = true;
      }

      if (state.createRoomRequestStatus == CreateRoomRequestStatus.left) {
        isIAdminInRoom = false;
      }
    }, builder: (context, state) {
      switch (state.createRoomRequestStatus) {
        case CreateRoomRequestStatus.idle:
          isIAdminInRoom = false;
          return const CreateRoomButtonDesign();
        case CreateRoomRequestStatus.loading:
          return const Center(child: CircularProgressIndicator());
        case CreateRoomRequestStatus.success:
          isIAdminInRoom = true;
          return const CreateRoomButtonDesign();
        case CreateRoomRequestStatus.left:
          isIAdminInRoom = false;
          return const CreateRoomButtonDesign();
        case CreateRoomRequestStatus.error:
          isIAdminInRoom = false;
          return const CreateRoomButtonDesign();
      }
    });
  }
}
