import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/params.dart';
import '../../../../../core/routes/app_route_names.dart';
import '../../../../../core/widgets/cached_network_image_circle_photo.dart';
import '../../../domain/entities/room_message_entitie_data.dart';

class RoomChatCardUserPhotoWidget extends StatelessWidget {
  const RoomChatCardUserPhotoWidget({
    super.key,
    required this.roomMessageDataEntitie,
  });

  final RoomMessageDataEntitie roomMessageDataEntitie;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () async {
            await Future.delayed(const Duration(milliseconds: 10), () {
              Navigator.of(context).pushNamed(
                AppRoutesNames.otherUserProfileScreen,
                arguments: OtherUserProfileScreenParams(
                  roomMessageDataEntitie.user!.id,
                ),
              );
            });
          },
          value: 1,
          child: Text(
            AppStrings.viewProfile.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        PopupMenuItem(
          onTap: () async {
            await Future.delayed(const Duration(milliseconds: 10), () {
              Navigator.of(context).pushNamed(
                AppRoutesNames.privateChatRoomScreen,
                arguments: PrivateChatRoomScreenParams(
                  roomUserDataEntitie: roomMessageDataEntitie.user!,
                ),
              );
            });
          },
          value: 2,
          child: Text(
            '${AppStrings.chatWith.tr()} ${roomMessageDataEntitie.user!.name} ${AppStrings.inPrivate.tr()}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p8, right: AppPadding.p8, top: AppPadding.p8),
        child: CachedNetworkImageCirclePhoto(
            photoUrl: roomMessageDataEntitie.user!.photo, photoRadius: 40),
      ),
    );
  }
}
