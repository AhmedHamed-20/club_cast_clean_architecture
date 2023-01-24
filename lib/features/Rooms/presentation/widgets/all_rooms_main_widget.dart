import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/rooms_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/room_card_widget.dart';

class AllRoomsMainWidget extends StatelessWidget {
  const AllRoomsMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsBloc, RoomsState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: ListView.builder(
          itemCount: state.allRoomsEntitie!.allRoomsDataEntitie.length,
          itemBuilder: (context, index) => RoomsCardWidget(
              allRoomsDataEntitie:
                  state.allRoomsEntitie!.allRoomsDataEntitie[index]),
        ),
      ),
    );
  }
}
