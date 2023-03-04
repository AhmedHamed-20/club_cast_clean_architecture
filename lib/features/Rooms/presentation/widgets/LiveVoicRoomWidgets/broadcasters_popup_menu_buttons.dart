import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_enitie.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/params.dart';
import '../../../../../core/routes/app_route_names.dart';
import '../../../data/models/active_room_user_model.dart';
import '../../../domain/entities/room_user_data.dart';

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
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: () {
          BlocProvider.of<SocketsVoiceBloc>(context).add(ReturnUserToAudience(
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
          ));
        },
      ),
      PopupMenuItem(
        child: Text(
          iMuteHim ? 'unMute' : 'Mute',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      PopupMenuItem(
        child: Text(
          'Chat With ${activeRoomUserDataEntitie.name} in Private',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: () {
          Future.delayed(
            const Duration(milliseconds: 10),
            () {
              Navigator.of(context).pushNamed(
                AppRoutesNames.privateChatRoomScreen,
                arguments: PrivateChatRoomScreenParams(
                  roomUserDataEntitie: RoomUserDataEntitie(
                    id: activeRoomUserDataEntitie.id,
                    name: activeRoomUserDataEntitie.name,
                    photo: activeRoomUserDataEntitie.photo,
                    uid: activeRoomUserDataEntitie.uid,
                  ),
                ),
              );
            },
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
    return [
      PopupMenuItem(
        child: Text(
          'Return To Listeners',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: () {
          BlocProvider.of<SocketsVoiceBloc>(context)
              .add(const ReturnToAudience());
        },
      ),
    ];
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
          'Chat With ${activeRoomUserDataEntitie.name} in Private',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: () {
          Future.delayed(
            const Duration(milliseconds: 10),
            () {
              Navigator.of(context).pushNamed(
                AppRoutesNames.privateChatRoomScreen,
                arguments: PrivateChatRoomScreenParams(
                  roomUserDataEntitie: RoomUserDataEntitie(
                    id: activeRoomUserDataEntitie.id,
                    name: activeRoomUserDataEntitie.name,
                    photo: activeRoomUserDataEntitie.photo,
                    uid: activeRoomUserDataEntitie.uid,
                  ),
                ),
              );
            },
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
  }
}
