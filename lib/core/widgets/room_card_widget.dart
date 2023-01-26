import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/rooms_admin_widget.dart';
import 'package:club_cast_clean_architecture/core/widgets/rooms_speakers_audience_widget.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/all_rooms_entitie_data.dart';
import 'package:flutter/material.dart';

class RoomsCardWidget extends StatelessWidget {
  const RoomsCardWidget({super.key, required this.allRoomsDataEntitie});
  final AllRoomsDataEntitie allRoomsDataEntitie;
  @override
  Widget build(BuildContext context) {
    return Card(
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
            height: 80,
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
    );
  }
}
