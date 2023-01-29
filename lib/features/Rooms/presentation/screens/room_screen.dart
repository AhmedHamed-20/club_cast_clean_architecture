import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/sockets_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottom_room_icons_widget.dart';
import '../widgets/rooms_audience_brodacsters_widget.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQueryOfMethods.getAppHeight(context) * 0.87,
              child: Card(
                color: Theme.of(context).colorScheme.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Live',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_sharp)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p12),
                      child: BlocBuilder<SocketsBloc, SocketsState>(
                        builder: (context, state) => Text(
                          state.joinCreateRoomEntitie!.roomName,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                        ),
                      ),
                    ),
                    const Expanded(child: RoomsAudienceBrodcastersWidget()),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
                child: BottomRoomIconsWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
