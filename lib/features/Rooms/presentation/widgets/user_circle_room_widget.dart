import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/base_room_user_data_enitie/base_room_user_data_entitie.dart';
import '../../../../core/constants/constants.dart';

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
          child: CachedNetworkImage(
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            imageUrl: baseRoomUserDataEntitie.photo,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/noImage.jpg'),
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
