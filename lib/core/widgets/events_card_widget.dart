import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

class EventsCardWidget extends StatelessWidget {
  const EventsCardWidget(
      {super.key,
      required this.date,
      required this.eventDescription,
      required this.eventsTitle,
      this.eventUserName,
      this.onPressedOnEdit,
      required this.isMyProfile,
      this.eventUserPhoto});
  final String eventsTitle;
  final String eventDescription;
  final String date;
  final String? eventUserName;
  final String? eventUserPhoto;
  final VoidCallback? onPressedOnEdit;
  final bool isMyProfile;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.r22)),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            eventUserPhoto != null
                ? Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CircleAvatar(
                        radius: AppRadius.r22,
                        backgroundImage: NetworkImage(eventUserPhoto!),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                eventsTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: AppHeight.h6,
              ),
              eventUserName != null
                  ? Text(
                      'From $eventUserName',
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: AppHeight.h6,
              ),
              Text(
                eventDescription,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(
                height: AppHeight.h6,
              ),
              Text(
                  DateTimeFormat.format(
                    DateTime.parse(date),
                    format: 'd/M/Y, H:i',
                  ),
                  style: Theme.of(context).textTheme.titleSmall),
            ]),
            if (eventUserPhoto == null && eventUserName == null ||
                isMyProfile == false)
              const Spacer(),
            if (eventUserPhoto == null &&
                eventUserName == null &&
                isMyProfile == true)
              Align(
                  alignment: AlignmentDirectional.topStart,
                  child: IconButton(
                    onPressed: onPressedOnEdit,
                    icon: const Icon(Icons.edit),
                  ))
          ],
        ),
      ),
    );
  }
}
