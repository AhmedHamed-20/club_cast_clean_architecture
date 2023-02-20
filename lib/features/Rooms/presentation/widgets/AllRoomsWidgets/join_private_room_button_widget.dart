import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/rooms_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utl/utls.dart';
import 'join_private_room_button_design.dart';

class JoinPrivateRoomButtonWidget extends StatelessWidget {
  const JoinPrivateRoomButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomsBloc, RoomsState>(listener: (context, state) {
      if (state.privateRoomsGetRequestStatus ==
          PrivateRoomsGetRequestStatus.success) {
        Navigator.pop(context);
      } else if (state.privateRoomsGetRequestStatus ==
          PrivateRoomsGetRequestStatus.error) {
        flutterToast(
          msg: state.errorMessage,
          backgroundColor: AppColors.toastError,
          textColor: AppColors.white,
        );
      }
    }, builder: (context, state) {
      switch (state.privateRoomsGetRequestStatus) {
        case PrivateRoomsGetRequestStatus.idle:
          return const JoinPrivateRoomButtonDesign();
        case PrivateRoomsGetRequestStatus.loading:
          return const Center(child: CircularProgressIndicator());
        case PrivateRoomsGetRequestStatus.success:
          return const JoinPrivateRoomButtonDesign();
        case PrivateRoomsGetRequestStatus.error:
          return const JoinPrivateRoomButtonDesign();
      }
    });
  }
}
