import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateRoomButtonDesign extends StatelessWidget {
  const CreateRoomButtonDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Defaults.defaultButton(
        onPressed: () {
          BlocProvider.of<SocketsBloc>(context)
              .add(ConnectToSocketEvent(ConstVar.accessToken));
        },
        context: context,
        text: 'Create Room');
  }
}
