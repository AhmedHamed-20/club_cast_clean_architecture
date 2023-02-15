import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/models/active_room_user_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_enitie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/routes/app_route_names.dart';
import '../../bloc/sockets/voice/sockets_voice_bloc.dart';

List<PopupMenuItem<dynamic>> popupMenuListenersButtons(
    {required BuildContext context,
    required bool iamAdmin,
    required iMuteHim,
    required ActiveRoomUserDataEntitie activeRoomUserDataEntitie}) {
  if (iamAdmin) {
    return [
      if (activeRoomUserDataEntitie.askedToSpeak)
        PopupMenuItem(
          child: Text(
            'Make Him Broadcaster',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onTap: () {
            BlocProvider.of<SocketsVoiceBloc>(context).add(
              GivePermsToUserToTalkEvent(
                activeRoomUserModel: ActiveRoomUserModel(
                  id: activeRoomUserDataEntitie.id,
                  name: activeRoomUserDataEntitie.name,
                  photo: activeRoomUserDataEntitie.photo,
                  uid: activeRoomUserDataEntitie.uid,
                  askedToSpeak: activeRoomUserDataEntitie.askedToSpeak,
                  iMuteHim: activeRoomUserDataEntitie.iMuteHim,
                  isMutted: activeRoomUserDataEntitie.isMutted,
                  isSpeaking: activeRoomUserDataEntitie.isSpeaking,
                ),
              ),
            );
          },
        ),
      PopupMenuItem(
        child: Text(
          'View Profile',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: () {
          Future.delayed(
            const Duration(milliseconds: 10),
            () {
              Navigator.of(context).pushNamed(
                AppRoutesNames.otherUserProfileScreen,
                arguments: OtherUserProfileScreenParams(
                  activeRoomUserDataEntitie.id,
                ),
              );
            },
          );
        },
      ),
    ];
  } else if (activeRoomUserDataEntitie.id == ConstVar.userId) {
    return [];
  } else {
    return [
      PopupMenuItem(
        child: Text(
          'View Profile',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: () {
          Future.delayed(
            const Duration(milliseconds: 10),
            () {
              Navigator.of(context).pushNamed(
                AppRoutesNames.otherUserProfileScreen,
                arguments: OtherUserProfileScreenParams(
                  activeRoomUserDataEntitie.id,
                ),
              );
            },
          );
        },
      ),
    ];
  }
}
