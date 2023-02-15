import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_enitie.dart';
import 'package:flutter/material.dart';

List<PopupMenuItem<dynamic>> popupMenuBroadCastersButtons(
    {required BuildContext context,
    required bool iamAdmin,
    required iMuteHim,
    required ActiveRoomUserDataEntitie activeRoomUserDataEntitie}) {
  if (iamAdmin) {
    return [
      PopupMenuItem(
        child: Text(
          'Make Him Listener',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      PopupMenuItem(
        child: Text(
          iMuteHim ? 'unMute' : 'Mute',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      PopupMenuItem(
        child: Text(
          'View Profile',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    ];
  } else if (activeRoomUserDataEntitie.id == ConstVar.userId) {
    return [];
  } else {
    return [
      PopupMenuItem(
        child: Text(
          iMuteHim ? 'unMute' : 'Mute',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      PopupMenuItem(
        child: Text(
          'View Profile',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    ];
  }
}
