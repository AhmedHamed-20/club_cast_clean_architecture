import 'package:club_cast_clean_architecture/core/routes/app_route_names.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/join_create_room_entitie.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class RoomsBottomSheetWidget extends StatelessWidget {
  const RoomsBottomSheetWidget(
      {super.key, required this.joinCreateRoomEntitie});
  final JoinCreateRoomEntitie joinCreateRoomEntitie;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutesNames.roomScreen);
      },
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppRadius.r22),
            topRight: Radius.circular(AppRadius.r22),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  joinCreateRoomEntitie.roomName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.mic,
                    color: Theme.of(context).colorScheme.secondary,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
