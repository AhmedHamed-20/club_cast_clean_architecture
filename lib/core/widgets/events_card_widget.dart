import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';

class EventsCardWidget extends StatelessWidget {
  const EventsCardWidget(
      {super.key,
      required this.date,
      required this.eventDescription,
      required this.eventsTitle,
      this.eventUserName,
      this.onPressedOnEdit,
      this.eventUserPhoto});
  final String eventsTitle;
  final String eventDescription;
  final String date;
  final String? eventUserName;
  final String? eventUserPhoto;
  final VoidCallback? onPressedOnEdit;
  @override
  Widget build(BuildContext context) {
    return Card(
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
                    child: CircleAvatar(
                      radius: AppRadius.r22,
                      backgroundImage: NetworkImage(eventUserPhoto!),
                    ),
                  )
                : const SizedBox.shrink(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventsTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: AppHeight.h6,
                ),
                eventUserName != null
                    ? Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: Text(
                          'From $eventUserName',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    : const SizedBox.shrink(),
                Text(
                  eventDescription,
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ],
            ),
            if (eventUserPhoto == null && eventUserName == null) const Spacer(),
            if (eventUserPhoto == null && eventUserName == null)
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
