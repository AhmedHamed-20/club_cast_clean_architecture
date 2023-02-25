import 'package:club_cast_clean_architecture/core/constants/base_event_entite/base_event_entitie.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/cached_network_image_circle_photo.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

class EventsCardWidget extends StatelessWidget {
  const EventsCardWidget(
      {super.key,
      required this.eventEntitie,
      this.eventUserName,
      this.onPressedOnEdit,
      required this.isMyProfile,
      this.onPressedOnNotification,
      required this.isHomeScreen,
      this.eventUserPhoto});
  final BaseEventEntitie eventEntitie;
  final String? eventUserName;
  final String? eventUserPhoto;
  final VoidCallback? onPressedOnEdit;
  final VoidCallback? onPressedOnNotification;
  final bool isHomeScreen;
  final bool isMyProfile;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppElevation.eL4,
      color: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.r22)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                eventEntitie.eventName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              (eventUserPhoto == null &&
                      eventUserName == null &&
                      isMyProfile == true)
                  ? IconButton(
                      onPressed: onPressedOnEdit,
                      icon: const Icon(Icons.edit),
                    )
                  : IconButton(
                      onPressed: onPressedOnEdit,
                      icon: const Icon(Icons.notifications),
                    ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Text(
            eventEntitie.eventDescription,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.start,
            overflow: isHomeScreen ? TextOverflow.ellipsis : null,
            maxLines: isHomeScreen ? 2 : null,
          ),
        ),
        if (isHomeScreen) const Spacer(),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                eventUserPhoto != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: AppPadding.p8),
                        child: CachedNetworkImageCirclePhoto(
                          photoRadius: 50,
                          photoUrl: eventUserPhoto!,
                        ),
                      )
                    : const SizedBox.shrink(),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (eventUserName != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppPadding.p6),
                        child: Text('From $eventUserName',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                )),
                      ),
                    Text(
                        DateTimeFormat.format(
                          DateTime.parse(eventEntitie.eventDate),
                          format: 'd/M/Y, H:i',
                        ),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            )),
                  ],
                ),
              ],
            ))
      ]),
    );
  }
}
