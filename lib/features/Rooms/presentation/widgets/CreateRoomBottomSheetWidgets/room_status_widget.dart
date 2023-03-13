import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

bool isPublic = true;

class RoomStatusWidget extends StatelessWidget {
  const RoomStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isPublic
              ? Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.public.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: AppHeight.h6,
                      ),
                      Text(
                        AppStrings.anyoneCanJoin.tr(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.private.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: AppHeight.h6,
                      ),
                      Text(
                        AppStrings.onlyPeopleWithTheLinkCanJoin.tr(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary),
                      ),
                    ],
                  ),
                ),
          Switch(
              value: isPublic,
              onChanged: (value) {
                setState(() {
                  isPublic = value;
                });
              }),
        ],
      ),
    );
  }
}
