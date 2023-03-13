import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/models/active_room_user_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_enitie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/routes/app_route_names.dart';
import '../../../domain/entities/room_user_data.dart';
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
            AppStrings.makeHimBroadcaster.tr(),
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
          AppStrings.viewProfile.tr(),
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
      PopupMenuItem(
        child: Text(
          '${AppStrings.chatWith.tr()} ${activeRoomUserDataEntitie.name} ${AppStrings.inPrivate.tr()}',
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
    ];
  } else if (activeRoomUserDataEntitie.id == ConstVar.userId) {
    return [];
  } else {
    return [
      PopupMenuItem(
        child: Text(
          '${AppStrings.chatWith.tr()} ${activeRoomUserDataEntitie.name} ${AppStrings.inPrivate.tr()}}',
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
          AppStrings.viewProfile.tr(),
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
