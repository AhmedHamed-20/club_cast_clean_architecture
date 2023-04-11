import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/active_room_user_data_entity.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/params.dart';
import '../../../../../core/routes/app_route_names.dart';
import '../../../data/models/active_room_user_model.dart';
import '../../../data/models/all_rooms_user_data.dart';

List<PopupMenuItem<dynamic>> popupMenuBroadCastersButtons(
    {required BuildContext context,
    required bool iamAdmin,
    required ActiveRoomUserDataEntity activeRoomUserDataEntitie}) {
  final socketVoiceBloc = BlocProvider.of<SocketsVoiceBloc>(context);
  if (iamAdmin) {
    return [
      PopupMenuItem(
        child: Text(
          AppStrings.makeHimListener.tr(),
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
        onTap: () {
          socketVoiceBloc.add(MuteSomeOneEvent(
              uid: activeRoomUserDataEntitie.uid,
              isMuted: !activeRoomUserDataEntitie.iMuteHim));
        },
        child: Text(
          activeRoomUserDataEntitie.iMuteHim
              ? AppStrings.unMute.tr()
              : AppStrings.mute.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
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
                  roomUserDataEntitie: RoomsUserDataModel(
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
  } else if (activeRoomUserDataEntitie.id == ConstVar.userId) {
    return [
      PopupMenuItem(
        child: Text(
          AppStrings.returnToListeners.tr(),
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
        onTap: () {
          socketVoiceBloc.add(MuteSomeOneEvent(
              uid: activeRoomUserDataEntitie.uid,
              isMuted: !activeRoomUserDataEntitie.iMuteHim));
        },
        child: Text(
          activeRoomUserDataEntitie.iMuteHim
              ? AppStrings.unMute.tr()
              : AppStrings.mute.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
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
                  roomUserDataEntitie: RoomsUserDataModel(
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
