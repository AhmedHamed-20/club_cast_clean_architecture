import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/sockets_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/user_circle_room_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomsAudienceBrodcastersWidget extends StatelessWidget {
  const RoomsAudienceBrodcastersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Broadcasters',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            SizedBox(
              height: AppHeight.h10,
            ),
            BlocBuilder<SocketsBloc, SocketsState>(
              builder: (context, state) => GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.brodcastersEnitite!.brodcasters.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return state.isCreateRoom
                        ? UserCircleRoomWidget(
                            baseRoomUserDataEntitie: state.meEntitie!.me,
                          )
                        : UserCircleRoomWidget(
                            baseRoomUserDataEntitie: state.adminEntitie!.admin,
                          );
                  } else {
                    return UserCircleRoomWidget(
                      baseRoomUserDataEntitie:
                          state.brodcastersEnitite!.brodcasters[index],
                    );
                  }
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
              ),
            ),
            SizedBox(
              height: AppHeight.h10,
            ),
            Center(
              child: Text(
                'Audience',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            SizedBox(
              height: AppHeight.h10,
            ),
            BlocBuilder<SocketsBloc, SocketsState>(
              builder: (context, state) => GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.audienceEntitie!.audience.length,
                itemBuilder: (context, index) {
                  return UserCircleRoomWidget(
                    baseRoomUserDataEntitie:
                        state.audienceEntitie!.audience[index],
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
