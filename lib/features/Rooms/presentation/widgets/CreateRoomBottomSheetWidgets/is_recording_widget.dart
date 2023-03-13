import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/storage_permission_download_path.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

bool isRecordingRoom = false;

class IsRecordingWidget extends StatelessWidget {
  const IsRecordingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isRecordingRoom
              ? Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.recording.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: AppHeight.h6,
                      ),
                      Text(
                        AppStrings.theRoomWillBeRecordedAndSavedToYourStorage
                            .tr(),
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
                        AppStrings.notRecording.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: AppHeight.h6,
                      ),
                      Text(
                        AppStrings.theRoomWillNotBeRecorded.tr(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary),
                      ),
                    ],
                  ),
                ),
          Switch(
              value: isRecordingRoom,
              onChanged: (value) async {
                setState(() {
                  isRecordingRoom = value;
                });
                if (value == true) {
                  if (await StoragePermissionAndPath
                          .checkStoragePermissions() ==
                      false) {
                    setState(() {
                      isRecordingRoom = false;
                    });
                    flutterToast(
                      msg: AppStrings.pleaseGrantPermissionToAccessYourStorage
                          .tr(),
                      backgroundColor: AppColors.toastWarning,
                      textColor: AppColors.black,
                    );
                  }
                }
              }),
        ],
      ),
    );
  }
}
