import 'package:club_cast_clean_architecture/core/widgets/cached_network_image_circle_photo.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/room_message_entitie_data.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class ChatTextCardWidget extends StatelessWidget {
  const ChatTextCardWidget({super.key, required this.roomMessageDataEntitie});

  final RoomMessageDataEntitie roomMessageDataEntitie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Row(
        mainAxisAlignment: roomMessageDataEntitie.isMine!
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Card(
              color: roomMessageDataEntitie.isMine!
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.secondaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(AppRadius.r8),
                  topRight: const Radius.circular(AppRadius.r8),
                  bottomLeft: roomMessageDataEntitie.isMine!
                      ? const Radius.circular(AppRadius.r8)
                      : const Radius.circular(0),
                  bottomRight: roomMessageDataEntitie.isMine!
                      ? const Radius.circular(0)
                      : const Radius.circular(AppRadius.r8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: roomMessageDataEntitie.isMine!
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!roomMessageDataEntitie.isMine!)
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppPadding.p8, right: AppPadding.p8),
                        child: CachedNetworkImageCirclePhoto(
                            photoUrl: roomMessageDataEntitie.user!.photo,
                            photoRadius: 40),
                      ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: roomMessageDataEntitie.isMine!
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (!roomMessageDataEntitie.isMine!)
                            Text(
                              roomMessageDataEntitie.user!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          SizedBox(height: AppHeight.h10),
                          Text(
                            roomMessageDataEntitie.message,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: AppHeight.h10),
                          Text(
                            DateTimeFormat.format(
                              DateTime.parse(roomMessageDataEntitie.createdAt!),
                              format: 'H:i',
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
