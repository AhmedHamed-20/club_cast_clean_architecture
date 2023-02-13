import 'package:club_cast_clean_architecture/core/widgets/cached_network_image_circle_photo.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncomingMessageListTileWidget extends StatelessWidget {
  const IncomingMessageListTileWidget(
      {super.key,
      required this.message,
      required this.userName,
      this.onPressedOnTrailing,
      required this.userPhoto});
  final String message;
  final String userName;
  final String userPhoto;
  final VoidCallback? onPressedOnTrailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 50.h,
        width: 50.w,
        child: CachedNetworkImageCirclePhoto(
          photoRadius: 50,
          photoUrl: userPhoto,
        ),
      ),
      title: Text(
        userName,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(
        message,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      trailing: onPressedOnTrailing != null
          ? Defaults.defaultTextButton(
              onPressed: onPressedOnTrailing!,
              child: Text(
                'Reply',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              ))
          : const SizedBox.shrink(),
    );
  }
}
