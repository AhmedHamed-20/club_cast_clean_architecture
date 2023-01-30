import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/sockets_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/create_room_button_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';

class CreateRoomButtonWidget extends StatelessWidget {
  const CreateRoomButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketsBloc, SocketsState>(builder: (context, state) {
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
