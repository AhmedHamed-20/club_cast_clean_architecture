import 'package:club_cast_clean_architecture/core/widgets/cached_network_image_circle_photo.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/base_room_user_data_enitie/base_room_user_data_entitie.dart';
import '../../../../../core/constants/constants.dart';

class UserCircleRoomWidget extends StatelessWidget {
  const UserCircleRoomWidget({
    super.key,
    required this.baseRoomUserDataEntitie,
  });
  final BaseRoomUserDataEntitie baseRoomUserDataEntitie;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CachedNetworkImageCirclePhoto(
            photoUrl: baseRoomUserDataEntitie.photo,
            photoRadius: 50,
          ),
        ),
        SizedBox(
          height: AppHeight.h6,
        ),
        Text(
          baseRoomUserDataEntitie.name,
          style: Theme.of(context).textTheme.titleSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
