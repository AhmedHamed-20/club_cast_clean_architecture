import 'package:club_cast_clean_architecture/core/widgets/cached_network_image_circle_photo.dart';
import 'package:flutter/material.dart';

import '../constants/base_all_rooms_data_entite/base_all_rooms_data_entitie.dart';
import '../constants/constants.dart';

class AdminRoomsWidget extends StatelessWidget {
  const AdminRoomsWidget({
    Key? key,
    required this.allRoomsDataEntitie,
  }) : super(key: key);
  final BaseAllRoomsDataEntitie allRoomsDataEntitie;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CachedNetworkImageCirclePhoto(
                photoUrl: allRoomsDataEntitie.admin.photo, photoRadius: 50),
            SizedBox(
              width: AppWidth.w6,
            ),
            Text(
              allRoomsDataEntitie.admin.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).secondaryHeaderColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              width: AppWidth.w6,
            ),
            Card(
              color: Theme.of(context).colorScheme.background,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r5)),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p4),
                child: Text(
                  'Host',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            const Spacer(),
            allRoomsDataEntitie.isRecording
                ? Image.asset('assets/images/recording.gif',
                    width: AppWidth.w44, height: AppHeight.h46)
                : const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
