import 'package:club_cast_clean_architecture/core/constants/base_all_rooms_data_entity/base_all_rooms_data_entity.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/rooms_admin_widget.dart';
import 'package:club_cast_clean_architecture/core/widgets/rooms_speakers_audience_widget.dart';
import 'package:flutter/material.dart';

class RoomsCardWidget extends StatelessWidget {
  const RoomsCardWidget({super.key, required this.allRoomsDataEntitie});
  final BaseAllRoomsDataEntity allRoomsDataEntitie;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Card(
        elevation: AppElevation.eL4,
        color: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.r22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Text(
                allRoomsDataEntitie.name,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 28),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Text(
                allRoomsDataEntitie.category,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            (allRoomsDataEntitie.audience.isEmpty &&
                    allRoomsDataEntitie.brodcasters.isEmpty)
                ? Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: Text(
                      'No one in the room',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: RoomsAudienceSpeakersWidget(
                        allRoomsDataEntitie: allRoomsDataEntitie),
                  ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppPadding.p12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppRadius.r22),
                  bottomRight: Radius.circular(
                    AppRadius.r22,
                  ),
                ),
              ),
              child: AdminRoomsWidget(allRoomsDataEntitie: allRoomsDataEntitie),
            ),
          ],
        ),
      ),
    );
  }
}
